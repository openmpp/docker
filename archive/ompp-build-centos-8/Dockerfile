# Docker image to build openM++ latest version on CentOS 8
#
# Examples of build and arguments default values:
#   podman build -t openmpp/openmpp-build:centos-8 .
#   podman build -t openmpp/openmpp-build:centos-8 --build-arg OMPP_USER=ompp .
#
# Examples of run, mapping your login user, group and home to container:
#
#   podman run \
#     -userns=host \
#     -v $HOME/build:/home/build:z \
#     -e OMPP_USER=build \
#     openmpp/openmpp-build:centos-8 \
#     ./build-all
#
#   podman run \
#     -userns=host \
#     -v $HOME/build_mpi:/home/build_mpi:z \
#     -e OMPP_USER=build_mpi \
#     -e OM_MSG_USE=MPI \
#     openmpp/openmpp-build:centos-8 \
#     ./build-all
#
#   podman run .... -e OM_MSG_USE=MPI      openmpp/openmpp-build:centos-8 ./build-openm
#   podman run .... -e MODEL_DIRS=modelOne openmpp/openmpp-build:centos-8 ./build-models
#   podman run .... openmpp/openmpp-build:centos-8 ./build-go
#   podman run .... openmpp/openmpp-build:centos-8 ./build-r
#   podman run .... openmpp/openmpp-build:centos-8 ./build-ui
#   podman run .... openmpp/openmpp-build:centos-8 ./build-tar-gz
#
#   podman run -it openmpp/openmpp-build:centos-8 bash

FROM centos:8

# update base image
RUN dnf -y update && dnf clean all

# install c++, Open MPI, build utils, git and SQLite
RUN dnf -y --setopt=tsflags=nodocs install make && \
  dnf -y --setopt=tsflags=nodocs install flex && \
  dnf -y --setopt=tsflags=nodocs install git && \
  dnf -y --setopt=tsflags=nodocs install sqlite && \
  dnf -y --setopt=tsflags=nodocs install gcc-c++ && \
  dnf -y --setopt=tsflags=nodocs install openmpi openmpi-devel

# download and install bison 3.7.x
#
# install makeinfo from pwertools repository
RUN dnf -y install dnf-plugins-core && \
  dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
  dnf config-manager --set-enabled powertools && \
  dnf -y install texinfo

RUN BISON_VER=3.7.5; \
  curl -L -o /tmp/bison-setup.tar.gz https://ftp.gnu.org/gnu/bison/bison-${BISON_VER}.tar.gz && \
  tar -xzf /tmp/bison-setup.tar.gz -C /tmp && \
  cd /tmp/bison-${BISON_VER} && \
  ./configure --prefix=/usr && \
  make && \
  make install && \
  cd ~ && \
  rm -rf /tmp/bison-${BISON_VER} && \
  rm /tmp/bison-setup.tar.gz

# download and install Go
RUN GO_VER=1.17.5; \
  curl -L -o /tmp/go_setup.tar.gz https://dl.google.com/go/go${GO_VER}.linux-amd64.tar.gz && \
  tar -xzf /tmp/go_setup.tar.gz -C /tmp && \
  mv /tmp/go / && \
  rm -rf /tmp/gocache /tmp/tmp && \
  rm /tmp/go_setup.tar.gz

# download and install unixODBC (optional)
RUN dnf -y --setopt=tsflags=nodocs install unixODBC && \
  dnf --setopt=tsflags=nodocs -y install unixODBC-devel

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
RUN NODE_VER=v14.18.2; \
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
  chmod 744 /scripts/README.txt

# describe image
#
LABEL name=openmpp/openmpp-build:centos-8
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
