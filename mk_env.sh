#!/bin/bash
# Script to create a new anaconda virtual environment.

set_link () {
    local PYD="$(find ${CONDA_ROOT}/envs/${1}/lib -maxdepth 1 -type d -name '*python3.*')"
    ln -s "${PROJECT_HOME}/utilities" "${PYD}/site-packages/utilities"
}

if [ $# -lt 1 ]; then
    printf "\n\tUsage: mkenv env_name [/full/path/to/package/config/file (default=${CONDA_ROOT}/env_configs/env_name.yml)]\n\n"
else
    if [ "${2}" ]; then
        printf "\tCreating environment with ${2} as config file.\n\n"
        conda env create -f "${2}"
        set_link "${1}"
    else
        if [ -f "${CONDA_ROOT}/env_configs/${1}.yml" ]; then
            printf "\tCreating environment with ${1}.yml as config file.\n\n"
            conda env create -f "${CONDA_ROOT}/env_configs/${1}.yml"
            set_link "${1}"
        else
            printf "\n\tNo config file ${1}.yml in ${CONDA_ROOT}/env_configs.\n\tPlease check the name.\n\n"
        fi
    fi
fi
