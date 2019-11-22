#!/usr/bin/env bash
set -e

# display help text prompt if user want to see it
if [ "$1" = '-?' ] || [ "$1" = '-h' ] || [ "$1" = '--help' ]; then
  exec cat /scripts/README.txt
fi

# set environment: build directory
#
export BUILD_DIR=/home/${OMPP_USER}

# copy build scripts
# if no volume mounted then make build directory
if [ ! -d ${BUILD_DIR} ]; then mkdir ${BUILD_DIR}; fi

cp -uv \
 /scripts/build-all \
 /scripts/build-openm \
 /scripts/build-models \
 /scripts/build-go \
 /scripts/build-r \
 /scripts/build-ui \
 /scripts/build-tar-gz \
 /scripts/README.txt \
 ${BUILD_DIR}

# set environment: open MPI, Go, node.js, R
cd ${BUILD_DIR}

source /usr/share/Modules/init/bash
module load mpi/openmpi-x86_64

export GOROOT=/go
export GOPATH=${BUILD_DIR}/ompp/ompp-go

export PATH=${GOROOT}/bin:${GOPATH}/bin:/node/bin:${PATH}

# done: execute command line arguments
#
${@}
