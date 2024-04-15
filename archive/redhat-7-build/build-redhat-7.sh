#!/usr/bin/env bash
#
# OpenM++ build script for RedHat 7
# you can customize this script or any scripts below in order to change build results
#
# Expected to be installed: devtoolset-9
#
# Environment variables and default values:
#   SQLITE_PATH = ${HOME}/sqlite
#                         sqlite/bin
#   BISON_PATH  = ${HOME}/bison
#                         bison/bin
#                         bison/lib
#   GOROOT      = ${HOME}/go
#                         go/bin
#   NODE_PATH   = ${HOME}/node
#                         node/bin
#
# Output directory:
#   OUT_BUILD_PATH = ${HOME}/build

set -e

# define environment
[ -z "${OUT_BUILD_PATH}" ] && export OUT_BUILD_PATH=${HOME}/build
[ -z "${SQLITE_PATH}" ]    && export SQLITE_PATH=${HOME}/sqlite
[ -z "${BISON_PATH}" ]     && export BISON_PATH=${HOME}/bison
[ -z "${GOROOT}" ]         && export GOROOT=${HOME}/go
[ -z "${NODE_PATH}" ]      && export NODE_PATH=${HOME}/node

echo Environment:
echo " OUT_BUILD_PATH = ${OUT_BUILD_PATH}"
echo " SQLITE_PATH    = ${SQLITE_PATH}"
echo " BISON_PATH     = ${BISON_PATH}"
echo " GOROOT         = ${BISON_PATH}"
echo " NODE_PATH      = ${NODE_PATH}"

# execute command, echo results and exit on errors
do_cmd()
{
  echo $@
  
  if ! $@;
  then
    echo FAILED.
    exit 1
  fi
}

# for c++17 use dev toolset
do_cmd source scl_source enable devtoolset-9

# sqlite3 must be at least 3.8.3, recommended year 2020 and after
export PATH=${SQLITE_PATH}/bin:${PATH}

# bison must be at least 3.3, recommended: >= 3.7.5
export PATH=${BISON_PATH}/bin:${PATH}
export LDFLAGS="-L${BISON_PATH}/lib ${LDFLAGS}"

# Go must be at least 1.17, recommended: >= 1.19
export GOPATH=${OUT_BUILD_PATH}/ompp
export PATH=${GOROOT}/bin:${PATH}

# Node.js 16.x recommended, 18.x not working on RedHat 7
export PATH=${NODE_PATH}/bin:${PATH}

# make and use output build directory
if [ ! -d ${OUT_BUILD_PATH} ]; then mkdir -pv ${OUT_BUILD_PATH}; fi

do_cmd cp -uv \
  build-redhat-7.sh \
  build-openm \
  ../ompp-build-redhat/build-models \
  ../ompp-build-redhat/build-go \
  ../ompp-build-redhat/build-r \
  build-ui \
  build-tar-gz \
  ../ompp-build-redhat/model.ini \
  ${OUT_BUILD_PATH}

# do build 

do_cmd pushd ${OUT_BUILD_PATH}

do_cmd chmod a+x "build-*"

./build-openm && \
./build-models && \
./build-go && \
./build-r && \
./build-ui && \
./build-tar-gz

popd

