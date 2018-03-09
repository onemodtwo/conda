#!/bin/bash
# setup_spark.sh: shell script to set up Spark in a conda environment

if [ $# -lt 1 ]; then
  printf "\nUsage: sp_setup spark_version\n\n"
  # usage message assumes a bash alias: alias sp_setup='<path-to-script>/setup_spark.sh'
else
  ## create ipython profile and startup script if this Spark version has not yet been set up
  if [ ! -d $HOME/.ipython/profile_pyspark${1} ]; then
    # create ipython profile in ~/.ipython
    ipython profile create pyspark${1}
    # write python startup script into profile startup directory
    PROFILE_FP=$HOME/.ipython/profile_pyspark${1}/startup/00-pyspark${1}-setup.py 
    printf "import os\n" > $PROFILE_FP
    printf "import sys\n" >> $PROFILE_FP
    printf "import fnmatch\n" >> $PROFILE_FP
    printf "spark_home = os.path.expanduser('~/bin/spark/spark${1}')\n" >> $PROFILE_FP
    printf "for file in os.listdir(os.path.join(spark_home, 'python/lib')):\n" >> $PROFILE_FP
    printf "    if fnmatch.fnmatch(file, 'py4j-*-src.zip'):\n" >> $PROFILE_FP
    printf "        py4j_version = 'py4j-' + file.split('-')[1] + '-src.zip'\n" >> $PROFILE_FP
    printf "sys.path.insert(0, os.path.join(spark_home, 'python'))\n" >> $PROFILE_FP
    printf "sys.path.insert(0, os.path.join(spark_home, 'python/lib/', py4j_version))\n" >> $PROFILE_FP
    printf "exec(open(os.path.join(spark_home, 'python/pyspark/shell.py')).read())\n" >> $PROFILE_FP
    unset PROFILE_FP
  fi
  ## write kernel spec to kernel directory for this conda environment
  PREFIX=$CONDA_PREFIX/etc/conda
  # make required directories
  mkdir -p $PREFIX/activate.d
  mkdir -p $PREFIX/deactivate.d
  mkdir -p $CONDA_PREFIX/share/jupyter/kernels/pyspark
  # write out kernel spec
  printf '{
  "argv": [
    "'${CONDA_PREFIX}'/bin/python",
    "-m",
    "ipykernel_launcher",
    "--profile=pyspark'${1}'",
    "-f",
    "{connection_file}"
  ],
  "display_name": "PySpark (Spark '${1}')",
  "language": "python",
  "env": {
    "CAPTURE_STANDARD_OUT": "true",
    "CAPTURE_STANDARD_ERR": "true",
    "SEND_EMPTY_OUTPUT": "false",
    "SPARK_HOME": "'${HOME}'/bin/spark/spark'${1}'"
  }\n}\n' > $CONDA_PREFIX/share/jupyter/kernels/pyspark/kernel.json
  # create activation script
  echo 'export PATH=$HOME/bin/spark/spark'${1}'/bin:$PATH' >> $PREFIX/activate.d/set_path.sh
  # create deactivation script
  echo 'export PATH=$CONDA_PREFIX/bin:$CONDA_PATH_BACKUP' >> $PREFIX/deactivate.d/unset_path.sh
  unset PREFIX
fi
