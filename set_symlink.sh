#!/bin/bash

set_link () {
    local PYD="$(find ${CONDA_ROOT}/envs/${1}/lib -maxdepth 1 -type d -name '*python3.*')"
    ln -s "${PROJECT_HOME}/utilities" "${PYD}/site-packages/utilities"
}
set_link "${1}"
