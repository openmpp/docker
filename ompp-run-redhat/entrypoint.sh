#!/usr/bin/env bash
set -e

# set environment: models home directory
# if no volume mounted then make home directory
#
export HOME=/home/${OMPP_USER}

if [ ! -d ${HOME} ]; then mkdir ${HOME}; fi

cp -uv /scripts/README.txt ${HOME}

# set environment and enable OpenMPI
#
cd ${HOME}
export OM_ROOT=${HOME}

source /usr/share/Modules/init/bash
module load mpi/openmpi-x86_64

# done: execute command line arguments
#
# ${@}
# step down from root to OMPP_USER
#
exec setpriv --reuid ${OMPP_UID} --regid ${OMPP_GID} --clear-groups "${@}"
