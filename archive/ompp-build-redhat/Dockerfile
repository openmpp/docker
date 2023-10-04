# Docker image to build openM++ latest version on Rocky Linux 9
#
# Examples of build and arguments default values:
#   podman build -t openmpp/openmpp-build:redhat-9 .
#   podman build -t openmpp/openmpp-build:redhat-9 --build-arg OMPP_USER=ompp .
#
# Examples of run, mapping your login user, group and home to container:
#
#   podman run \
#     -userns=host \
#     -v $HOME/build:/home/build:z \
#     -e OMPP_USER=build \
#     openmpp/openmpp-build:redhat-9 \
#     ./build-all
#
#   podman run \
#     -userns=host \
#     -v $HOME/build_mpi:/home/build_mpi:z \
#     -e OMPP_USER=build_mpi \
#     -e OM_MSG_USE=MPI \
#     openmpp/openmpp-build:redhat-9 \
#     ./build-all
#
#   podman run .... -e OM_MSG_USE=MPI      openmpp/openmpp-build:redhat-9 ./build-openm
#   podman run .... -e MODEL_DIRS=modelOne openmpp/openmpp-build:redhat-9 ./build-models
#   podman run .... openmpp/openmpp-build:redhat-9 ./build-go
#   podman run .... openmpp/openmpp-build:redhat-9 ./build-r
#   podman run .... openmpp/openmpp-build:redhat-9 ./build-ui
#   podman run .... openmpp/openmpp-build:redhat-9 ./build-tar-gz
#
#   podman run -it openmpp/openmpp-build:redhat-9 bash

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
RUN GO_VER=1.20.3; \
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
RUN NODE_VER=v18.16.0; \
  curl -L -o /tmp/node.tar.xz https://nodejs.org/dist/${NODE_VER}/node-${NODE_VER}-linux-x64.tar.xz && \
  mkdir /node && \
  tar -xJf /tmp/node.tar.xz -C /node --strip-components=1 && \
  rm /tmp/node.tar.xz

# set local openM++ timezone
RUN rm -f /etc/localtime && \
  ln -s /usr/share/zoneinfo/America/Toronto /etc/localtime

# copy entry point and build scripts
COPY entrypoint.sh \
  build-all \
  build-openm \
  build-models \
  build-go \
  build-r \
  build-ui \
  build-tar-gz \
  model.ini \
  README.txt \
  /scripts/

RUN chmod 755 /scripts/entrypoint.sh && \
  chmod 755 /scripts/build-all && \
  chmod 755 /scripts/build-openm && \
  chmod 755 /scripts/build-models && \
  chmod 755 /scripts/build-go && \
  chmod 755 /scripts/build-r && \
  chmod 755 /scripts/build-ui && \
  chmod 755 /scripts/build-tar-gz && \
  chmod 744 /scripts/model.ini && \
  chmod 744 /scripts/README.txt

# describe image
#
LABEL name=openmpp/openmpp-build:redhat-8
LABEL os=Linux
LABEL license=MIT
LABEL description="OpenM++ build environemnt: g++, make, OpenMPI, git, SQLite, bison, flex, Go, node.js"

# Done with installation
# set work directory argument
#
ARG OMPP_USER=ompp

ENV OMPP_USER  ${OMPP_USER}

# actual home directory is set by entrypoint.sh
#
# WORKDIR /home/${OMPP_USER}
#
ENTRYPOINT ["/scripts/entrypoint.sh"]

CMD ["cat", "/scripts/README.txt"]
