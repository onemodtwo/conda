#!/bin/bash
# Script to activate an anaconda virtual environment based upon project.

if [ $# -lt 1 ]; then
  printf "\nUsage: workon project_name\n\n"
else
  PROJ_CODE="${PROJECT_HOME}/${1}"
  ENV="$(cat ${PROJ_CODE}/.env)"
  conda activate "${ENV}"
  cd "${PROJ_CODE}"
fi
