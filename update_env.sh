#!/bin/bash
# Script to do a complete update to a conda
# environment using a config file if present

if [ -f "${CONDA_ROOT}/env_configs/${CONDA_DEFAULT_ENV}.yml" ]; then
    conda env update -f "${CONDA_ROOT}/env_configs/${CONDA_DEFAULT_ENV}.yml"
else
    conda env update --all
fi
