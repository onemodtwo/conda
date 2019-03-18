#!/bin/bash
# Script to deactivate an anaconda virtual environment.

PREFIX="${CONDA_PREFIX}"
conda deactivate # deactivate virtual environment
# run post-deactivate script
[ -d "${PREFIX}/etc/conda" ] && [ -f "${PREFIX}/etc/conda/__post-deactivate.sh" ] && source "${PREFIX}/etc/conda/__post-deactivate.sh"
unset PREFIX
cd "${PROJECT_HOME}"
