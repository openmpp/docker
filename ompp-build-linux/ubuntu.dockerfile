# Docker image to build openM++ latest version for Ubuntu LTS
#
# Examples of build and arguments default values:
#   docker build -t openmpp/openmpp-build:ubuntu -f ubuntu.dockerfile .
#   docker build -t openmpp/openmpp-build:ubuntu -f ubuntu.dockerfile --build-arg OMPP_USER=ompp .
#   docker build -t openmpp/openmpp-build:ubuntu -f ubuntu.dockerfile --build-arg OMPP_GIT_URL=https://github.com/openmpp .
#
# Examples of run, mapping your login user, group and home to container:
#
#   docker run \
#     -v $HOME/build:/home/build \
#     -e OMPP_USER=build -e OMPP_GROUP=build -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
#     -e OMPP_BUILD_TAG=v1.2.3 \
#     openmpp/openmpp-build:ubuntu \
#     ./build-all
#
#   docker run \
#     -v $HOME/build_mpi:/home/build_mpi \
#     -e OMPP_USER=build_mpi -e OMPP_GROUP=build_mpi -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
#     -e OMPP_BUILD_TAG=v1.2.3 \
#     -e OM_MSG_USE=MPI \
#     openmpp/openmpp-build:ubuntu \
#     ./build-all
#
#   docker run .... -e OM_MSG_USE=MPI     openmpp/openmpp-build:ubuntu ./build-openm
#   docker run .... -e MODEL_DIRS=MyModel openmpp/openmpp-build:ubuntu ./build-models
#   docker run .... openmpp/openmpp-build:ubuntu ./build-go
#   docker run .... openmpp/openmpp-build:ubuntu ./build-r
#   docker run .... openmpp/openmpp-build:ubuntu ./build-ui
#   docker run .... openmpp/openmpp-build:ubuntu ./build-tar-gz
#
#   sudo docker run .... -it openmpp/openmpp-build:ubuntu bash
#

FROM ubuntu:24.04

# disable debconf terminal input
ARG DEBIAN_FRONTEND=noninteractive

# update base image
RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get upgrade -y

# install c++, Open MPI, build utils, git and SQLite
RUN apt-get install -y g++ && \
  apt-get install -y make && \
  apt-get install -y bison flex && \
  apt-get install -y git && \
  apt-get install -y sqlite3 && \
  apt-get install -y openmpi-bin libopenmpi-dev

# install curl and xz packaging utils
RUN apt-get install -y curl && \
  apt-get install -y xz-utils

# download and install Go
RUN GO_VER=1.24.3; \
  curl -L -o /tmp/go_setup.tar.gz https://dl.google.com/go/go${GO_VER}.linux-amd64.tar.gz && \
  tar -xzf /tmp/go_setup.tar.gz -C /tmp && \
  mv /tmp/go / && \
  rm -rf /tmp/gocache /tmp/tmp && \
  rm /tmp/go_setup.tar.gz

# download and install unixODBC (optional)
RUN apt-get install -y unixodbc unixodbc-dev

# cleanup
RUN apt-get autoclean

# download and install node.js
RUN NODE_VER=v22.15.1; \
  curl -L -o /tmp/node.tar.xz https://nodejs.org/dist/${NODE_VER}/node-${NODE_VER}-linux-x64.tar.xz && \
  mkdir /node && \
  tar -xJf /tmp/node.tar.xz -C /node --strip-components=1 && \
  rm /tmp/node.tar.xz

# set local openM++ timezone
RUN apt-get install -y tzdata

RUN rm -f /etc/localtime && \
  ln -s /usr/share/zoneinfo/America/Toronto /etc/localtime

# copy entry point and build scripts
COPY ubuntu.entrypoint.sh \
  build-all \
  build-openm \
  build-models \
  build-go \
  build-r \
  build-ui \
  build-tar-gz \
  model.ini \
  make-model \
  README.make-model.linux.txt \
  README.ubuntu.txt \
  /scripts/

RUN chmod 755 /scripts/ubuntu.entrypoint.sh && \
  chmod 755 /scripts/build-all && \
  chmod 755 /scripts/build-openm && \
  chmod 755 /scripts/build-models && \
  chmod 755 /scripts/build-go && \
  chmod 755 /scripts/build-r && \
  chmod 755 /scripts/build-ui && \
  chmod 755 /scripts/build-tar-gz && \
  chmod 744 /scripts/model.ini && \
  chmod 755 /scripts/make-model && \
  chmod 744 /scripts/README.make-model.linux.txt && \
  chmod 744 /scripts/README.ubuntu.txt

# describe image
#
LABEL name=openmpp/openmpp-build:ubuntu
LABEL os=Linux
LABEL license=MIT
LABEL description="OpenM++ build environemnt: g++, make, OpenMPI, git, SQLite, bison, flex, Go, node.js"

# Done with installation
# set environment
#
ARG OMPP_USER=ompp
ENV OMPP_USER    ${OMPP_USER}
ENV OMPP_LINUX   ubuntu

# I am not documenting varaibles below
# because I think it is may be not a good idea to use it
#
ARG OMPP_GIT_URL=https://github.com/openmpp
ENV OMPP_GIT_URL ${OMPP_GIT_URL}

ARG OMPP_MAIN_GIT=main.git
ENV OMPP_MAIN_GIT ${OMPP_MAIN_GIT}

ARG OMPP_GO_GIT=go.git
ENV OMPP_GO_GIT ${OMPP_GO_GIT}

ARG OMPP_UI_GIT=UI.git
ENV OMPP_UI_GIT ${OMPP_UI_GIT}

ARG OMPP_DOCKER_GIT=docker.git
ENV OMPP_DOCKER_GIT ${OMPP_DOCKER_GIT}

ARG OMPP_MAC_GIT=mac.git
ENV OMPP_MAC_GIT ${OMPP_MAC_GIT}

ARG OMPP_R_GIT=R.git
ENV OMPP_R_GIT ${OMPP_R_GIT}

ARG OMPP_PYTHON_GIT=python.git
ENV OMPP_PYTHON_GIT ${OMPP_PYTHON_GIT}

ARG OMPP_OTHER_GIT=other.git
ENV OMPP_OTHER_GIT ${OMPP_OTHER_GIT}

# actual home directory is set by entrypoint.sh
#
# WORKDIR /home/${OMPP_USER}
#
ENTRYPOINT ["/scripts/ubuntu.entrypoint.sh"]

CMD ["cat", "/scripts/README.ubuntu.txt"]
