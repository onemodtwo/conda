#!/bin/bash
# Script to activate an anaconda virtual environment.

if [ $# -lt 1 ]; then
  printf "\nUsage: act env_name\n\n"
else
  PREFIX="${CONDA_ROOT}/envs/${1}"
  # run pre-activate script
  [ -d "${PREFIX}/etc/conda" ] && [ -f "${PREFIX}/etc/conda/__pre-activate.sh" ] &&  source "${PREFIX}/etc/conda/__pre-activate.sh"
  conda activate "${1}" # activate environment
  unset PREFIX
fi
