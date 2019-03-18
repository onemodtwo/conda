#!/bin/bash

TEMPLATE='{
	"folders": [
		{
			"path": "."
		}
	],
	"settings": {
		"python.pythonPath": "CONDA_ROOT/envs/ENV/bin/python"
	}
}'
[ -d "${PROJECT_HOME}/${1}" ] || mkdir "${PROJECT_HOME}/${1}"
printf "${2}" > "${PROJECT_HOME}/${1}/.env"
TEMPLATE="${TEMPLATE/CONDA_ROOT/${CONDA_ROOT}}"
printf "${TEMPLATE/ENV/${2}}\n" > "${PROJECT_HOME}/${1}/${1}.code-workspace"
