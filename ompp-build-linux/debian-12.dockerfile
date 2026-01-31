# Docker image to build openM++ latest version for Debian 12
# It is also can make latest version of openM++ documentation
#
# Examples of build and arguments default values:
#   docker build -t openmpp/openmpp-build:debian-12 -f debian-12.dockerfile .
#   docker build -t openmpp/openmpp-build:debian-12 -f debian-12.dockerfile --build-arg OMPP_USER=ompp .
#   docker build -t openmpp/openmpp-build:debian-12 -f debian-12.dockerfile --build-arg OMPP_GIT_URL=https://github.com/openmpp .
#
# Examples of run, mapping your login user, group and home to container:
#
#   docker run \
#     -v $HOME/build:/home/build \
#     -e OMPP_USER=build -e OMPP_GROUP=build -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
#     -e OMPP_BUILD_TAG=v1.2.3 \
#     openmpp/openmpp-build:debian-12 \
#     ./build-all
#
#   docker run \
#     -v $HOME/build_mpi:/home/build_mpi \
#     -e OMPP_USER=build_mpi -e OMPP_GROUP=build_mpi -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
#     -e OMPP_BUILD_TAG=v1.2.3 \
#     -e OM_MSG_USE=MPI \
#     openmpp/openmpp-build:debian-12 \
#     ./build-all
#
#   docker run .... -e OM_MSG_USE=MPI     openmpp/openmpp-build:debian-12 ./build-openm
#   docker run .... -e MODEL_DIRS=MyModel openmpp/openmpp-build:debian-12 ./build-models
#   docker run .... openmpp/openmpp-build:debian-12 ./build-go
#   docker run .... openmpp/openmpp-build:debian-12 ./build-r
#   docker run .... openmpp/openmpp-build:debian-12 ./build-ui
#   docker run .... openmpp/openmpp-build:debian-12 ./build-tar-gz
#
#   docker run .... -it openmpp/openmpp-build:debian-12 bash
#
FROM debian:12

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
  apt-get install -y openmpi-bin libopenmpi-dev && \
  apt-get install -y curl && \
  apt-get install -y xz-utils

# download and install Go
RUN GO_VER=1.25.5; \
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
RUN NODE_VER=v24.11.1; \
  curl -L -o /tmp/node.tar.xz https://nodejs.org/dist/${NODE_VER}/node-${NODE_VER}-linux-x64.tar.xz && \
  mkdir /node && \
  tar -xJf /tmp/node.tar.xz -C /node --strip-components=1 && \
  rm /tmp/node.tar.xz

# set local openM++ timezone
RUN rm -f /etc/localtime && \
  ln -s /usr/share/zoneinfo/America/Toronto /etc/localtime

# copy entry point and build scripts
COPY debian-12.entrypoint.sh \
  build-all \
  build-openm \
  build-models \
  build-go \
  build-r \
  build-ui \
  build-tar-gz \
  model.ini \
  make-doc \
  make-r \
  make-model \
  README.make-model.linux.txt \
  README.debian-12.txt \
  /scripts/

RUN chmod 755 /scripts/debian-12.entrypoint.sh && \
  chmod 755 /scripts/build-all && \
  chmod 755 /scripts/build-openm && \
  chmod 755 /scripts/build-models && \
  chmod 755 /scripts/build-go && \
  chmod 755 /scripts/build-r && \
  chmod 755 /scripts/build-ui && \
  chmod 755 /scripts/build-tar-gz && \
  chmod 755 /scripts/make-doc && \
  chmod 755 /scripts/make-r && \
  chmod 744 /scripts/model.ini && \
  chmod 755 /scripts/make-model && \
  chmod 744 /scripts/README.make-model.linux.txt && \
  chmod 744 /scripts/README.debian-12.txt

# describe image
#
LABEL name=openmpp/openmpp-build:debian-12
LABEL os=Linux
LABEL license=MIT
LABEL description="OpenM++ build environemnt: g++, make, OpenMPI, git, SQLite, bison, flex, Go, node.js"

# Done with installation
# set environment
#
ARG OMPP_USER=ompp
ENV OMPP_USER    ${OMPP_USER}
ENV OMPP_LINUX   debian-12

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
ENTRYPOINT ["/scripts/debian-12.entrypoint.sh"]

CMD ["cat", "/scripts/README.debian-12.txt"]
