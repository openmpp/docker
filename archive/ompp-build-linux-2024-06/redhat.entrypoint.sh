#!/usr/bin/env bash
set -e

# display help text prompt if user want to see it
if [ "$1" = '-?' ] || [ "$1" = '-h' ] || [ "$1" = '--help' ]; then
  exec cat /scripts/README.${OMPP_LINUX}.txt
fi

# set environment: home directory
#
export HOME=/home/${OMPP_USER}

# copy build scripts
cp -uv \
 /scripts/build-all \
 /scripts/build-openm \
 /scripts/build-models \
 /scripts/build-go \
 /scripts/build-r \
 /scripts/build-ui \
 /scripts/build-tar-gz \
 /scripts/model.ini \
 /scripts/README.${OMPP_LINUX}.txt \
 ${HOME}

chown -R ${OMPP_UID}:${OMPP_GID} ${HOME}
cd ${HOME}

# set environment: Open MPI, Go, node.js, R
#

source /usr/share/Modules/init/bash
module load mpi/openmpi-x86_64

export GOROOT=/go
export GOPATH=${HOME}/ompp

export PATH=${GOROOT}/bin:${GOPATH}/bin:/node/bin:${PATH}

export OMPP_LINUX=${OMPP_LINUX}

# step down from root to OMPP_USER and OMPP_GROUP
#
exec setpriv --reuid ${OMPP_UID} --regid ${OMPP_GID} --clear-groups "${@}"
