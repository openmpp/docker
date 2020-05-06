# Docker image to build openM++ latest version on CentOS 7
#
# Examples of build and arguments default values:
#   docker build -t openmpp/openmpp-build:centos-7 .
#   docker build -t openmpp/openmpp-build:centos-7 --build-arg OMPP_USER=ompp .
#   docker build -t openmpp/openmpp-build:centos-7 --build-arg OMPP_GROUP=ompp .
#   docker build -t openmpp/openmpp-build:centos-7 --build-arg OMPP_UID=1999 .
#   docker build -t openmpp/openmpp-build:centos-7 --build-arg OMPP_GID=1999 .
#
# Examples of run, mapping your login user, group and home to container:
#
#   docker run \
#     -v $HOME/build:/home/build \
#     -e OMPP_USER=build -e OMPP_GROUP=build -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
#     openmpp/openmpp-build:centos-7 \
#     ./build-all
#
#   docker run \
#     -v $HOME/build_mpi:/home/build_mpi \
#     -e OMPP_USER=build_mpi -e OMPP_GROUP=build_mpi -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
#     -e OM_MSG_USE=MPI \
#     openmpp/openmpp-build:centos-7 \
#     ./build-all
#
#   docker run ....user, group, home.... -e OM_MSG_USE=MPI     openmpp/openmpp-build:centos-7 ./build-openm
#   docker run ....user, group, home.... -e MODEL_DIRS=MyModel openmpp/openmpp-build:centos-7 ./build-models
#   docker run ....user, group, home.... openmpp/openmpp-build:centos-7 ./build-go
#   docker run ....user, group, home.... openmpp/openmpp-build:centos-7 ./build-r
#   docker run ....user, group, home.... openmpp/openmpp-build:centos-7 ./build-ui
#   docker run ....user, group, home.... openmpp/openmpp-build:centos-7 ./build-tar-gz
#
#   docker run -it openmpp/openmpp-build:centos-7 bash

FROM centos:7

# update base image
RUN yum -y update && yum clean all

# install c++17, Open MPI, build utils, git and SQLite
RUN yum -y install centos-release-scl && \
  yum -y install devtoolset-7-gcc-c++ && \
  yum -y install openmpi && \
  yum -y install openmpi-devel && \
  yum -y install make && \
  yum -y install bison && \
  yum -y install flex && \
  yum -y install git && \
  yum -y install sqlite && \
  yum clean all

# download and install Go
RUN GO_VER=1.14.1; \
  curl -L -o /tmp/go_setup.tar.gz https://dl.google.com/go/go${GO_VER}.linux-amd64.tar.gz && \
  tar -xzf /tmp/go_setup.tar.gz -C /tmp && \
  mv /tmp/go / && \
  rm -rf /tmp/gocache /tmp/tmp && \
  rm /tmp/go_setup.tar.gz

# download and install unixODBC (optional)
RUN yum -y install unixODBC && \
  yum -y install unixODBC-devel && \
  yum clean all

# download and install R
RUN rpm -Uvh https://download.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
  yum -y install R-core && \
  yum clean all

# download and install node.js
RUN NODE_VER=v12.14.1; \
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

# Done with installation
# set user, work directory and entry point
#
ARG OMPP_USER=ompp
ARG OMPP_GROUP=ompp
ARG OMPP_UID=1999
ARG OMPP_GID=1999

ENV OMPP_USER  ${OMPP_USER}
ENV OMPP_GROUP ${OMPP_GROUP}
ENV OMPP_UID   ${OMPP_UID}
ENV OMPP_GID   ${OMPP_GID}

# home directory and user are set by entrypoint.sh
#
# RUN groupadd -g $OMPP_GID ${OMPP_GROUP} && \
#   useradd --no-log-init -g ${OMPP_GROUP} -u $OMPP_UID ${OMPP_USER}
# 
# USER ${OMPP_USER}:${OMPP_GROUP}
# 
# WORKDIR /home/${OMPP_USER}/build

ENTRYPOINT ["/scripts/entrypoint.sh"]

CMD ["cat", "/scripts/README.txt"]

