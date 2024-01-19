# Docker image to build openM++ latest version for Rocky Linux 9
#
# Examples of build and arguments default values:
#   docker build -t openmpp/openmpp-build:redhat -f redhat.dockerfile .
#   docker build -t openmpp/openmpp-build:redhat -f redhat.dockerfile --build-arg OMPP_USER=ompp .
#   docker build -t openmpp/openmpp-build:redhat -f redhat.dockerfile --build-arg OMPP_GROUP=ompp .
#   docker build -t openmpp/openmpp-build:redhat -f redhat.dockerfile --build-arg OMPP_UID=1999 .
#   docker build -t openmpp/openmpp-build:redhat -f redhat.dockerfile --build-arg OMPP_GID=1999 .
#
# Examples of run, mapping your login user, group and home to container:
#
#   docker run \
#     -userns=host \
#     -v $HOME/build:/home/build:z \
#     -e OMPP_USER=build \
#     -e OMPP_BUILD_TAG=v1.2.3 \
#     openmpp/openmpp-build:redhat \
#     ./build-all
#
#   docker run \
#     -userns=host \
#     -v $HOME/build_mpi:/home/build_mpi:z \
#     -e OMPP_USER=build_mpi \
#     -e OMPP_BUILD_TAG=v1.2.3 \
#     -e OM_MSG_USE=MPI \
#     openmpp/openmpp-build:redhat \
#     ./build-all
#
#   docker run .... -e OM_MSG_USE=MPI      openmpp/openmpp-build:redhat ./build-openm
#   docker run .... -e MODEL_DIRS=modelOne openmpp/openmpp-build:redhat ./build-models
#   docker run .... openmpp/openmpp-build:redhat ./build-go
#   docker run .... openmpp/openmpp-build:redhat ./build-r
#   docker run .... openmpp/openmpp-build:redhat ./build-ui
#   docker run .... openmpp/openmpp-build:redhat ./build-tar-gz
#
#   docker run -it openmpp/openmpp-build:redhat bash

FROM rockylinux/rockylinux:9

# update base image
RUN dnf -y update && dnf clean all

# install c++, Open MPI, build utils, git and SQLite
RUN dnf -y --setopt=tsflags=nodocs install make && \
  dnf -y --setopt=tsflags=nodocs install flex && \
  dnf -y --setopt=tsflags=nodocs install bison && \
  dnf -y --setopt=tsflags=nodocs install git && \
  dnf -y --setopt=tsflags=nodocs install sqlite && \
  dnf -y --setopt=tsflags=nodocs install gcc-c++ && \
  dnf -y --setopt=tsflags=nodocs install openmpi openmpi-devel

# install extra utilities
RUN dnf -y --setopt=tsflags=nodocs install xz

# download and install Go
RUN GO_VER=1.21.6; \
  curl -L -o /tmp/go_setup.tar.gz https://dl.google.com/go/go${GO_VER}.linux-amd64.tar.gz && \
  tar -xzf /tmp/go_setup.tar.gz -C /tmp && \
  mv /tmp/go / && \
  rm -rf /tmp/gocache /tmp/tmp && \
  rm /tmp/go_setup.tar.gz

# download and install unixODBC (optional)
RUN dnf -y --setopt=tsflags=nodocs install unixODBC

RUN dnf -y --enablerepo=crb install unixODBC-devel

# download and install R
# RUN dnf install -y --setopt=tsflags=nodocs epel-release
#
# RUN dnf install -y --setopt=tsflags=nodocs dnf-plugins-core
#
# RUN dnf config-manager --set-enabled powertools
#
# RUN dnf -y --setopt=tsflags=nodocs install cups
#
# RUN dnf -y --setopt=tsflags=nodocs install R-core

# cleanup
RUN dnf clean all

# download and install node.js
RUN NODE_VER=v20.11.0; \
  curl -L -o /tmp/node.tar.xz https://nodejs.org/dist/${NODE_VER}/node-${NODE_VER}-linux-x64.tar.xz && \
  mkdir /node && \
  tar -xJf /tmp/node.tar.xz -C /node --strip-components=1 && \
  rm /tmp/node.tar.xz

# set local openM++ timezone
RUN rm -f /etc/localtime && \
  ln -s /usr/share/zoneinfo/America/Toronto /etc/localtime

# copy entry point and build scripts
COPY redhat.entrypoint.sh \
  build-all \
  build-openm \
  build-models \
  build-go \
  build-r \
  build-ui \
  build-tar-gz \
  model.ini \
  README.redhat.txt \
  /scripts/

RUN chmod 755 /scripts/redhat.entrypoint.sh && \
  chmod 755 /scripts/build-all && \
  chmod 755 /scripts/build-openm && \
  chmod 755 /scripts/build-models && \
  chmod 755 /scripts/build-go && \
  chmod 755 /scripts/build-r && \
  chmod 755 /scripts/build-ui && \
  chmod 755 /scripts/build-tar-gz && \
  chmod 744 /scripts/model.ini && \
  chmod 744 /scripts/README.redhat.txt

# describe image
#
LABEL name=openmpp/openmpp-build:redhat
LABEL os=Linux
LABEL license=MIT
LABEL description="OpenM++ build environemnt: g++, make, OpenMPI, git, SQLite, bison, flex, Go, node.js"

# Done with installation
# set work directory argument
#
ARG OMPP_USER=ompp

ENV OMPP_USER  ${OMPP_USER}
ENV OMPP_LINUX redhat

# actual home directory is set by entrypoint.sh
#
# WORKDIR /home/${OMPP_USER}
#
ENTRYPOINT ["/scripts/redhat.entrypoint.sh"]

CMD ["cat", "/scripts/README.redhat.txt"]
