#!/bin/bash
# Remove an anaconda environment

if [ $# -lt 1 ]; then
  printf "\nUsage: rmenv env_name\n\n"
else
  conda-env remove -n "${1}"
fi
