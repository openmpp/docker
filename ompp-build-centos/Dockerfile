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

# install c++, MPICH, build utils, git and SQLite
RUN dnf -y install make && \
  dnf -y install bison flex && \
  dnf -y install git && \
  dnf -y install sqlite && \
  dnf -y install gcc-c++ && \
  dnf -y install mpich mpich-devel && \
  dnf clean all

# download and install Go
RUN GO_VER=1.14.1; \
  curl -L -o /tmp/go_setup.tar.gz https://dl.google.com/go/go${GO_VER}.linux-amd64.tar.gz && \
  tar -xzf /tmp/go_setup.tar.gz -C /tmp && \
  mv /tmp/go / && \
  rm -rf /tmp/gocache /tmp/tmp && \
  rm /tmp/go_setup.tar.gz

# download and install unixODBC (optional)
RUN dnf -y install unixODBC && \
  dnf -y install unixODBC-devel && \
  dnf clean all

# download and install R
RUN dnf install -y epel-release && \
  dnf install -y dnf-plugins-core && \
  dnf config-manager --set-enabled PowerTools

RUN dnf -y install cups && \
  dnf -y install R-core && \
  dnf clean all

# download and install node.js
RUN NODE_VER=v12.14.1; \
  curl -L -o /tmp/node.tar.xz https://nodejs.org/dist/${NODE_VER}/node-${NODE_VER}-linux-x64.tar.xz && \
  mkdir /node && \
  tar -xJf /tmp/node.tar.xz -C /node --strip-components=1 && \
  rm /tmp/node.tar.xz

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
