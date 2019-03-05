# Docker image to build openM++ latest version on CentOS 7
#
# Examples of build:
#   docker build -t openmpp/openmpp-build:centos-7 .
#   docker build -t openmpp/openmpp-build:centos-7 --build-arg OMPP_USER=ompp .
#   docker build -t openmpp/openmpp-build:centos-7 --build-arg OMPP_UID=1000 .
#   docker build -t openmpp/openmpp-build:centos-7 --build-arg OMPP_GID=1000 .
#
# Examples of run:
#   docker run -v $HOME/build:/home/ompp/build     openmpp/openmpp-build:centos-7 build-all
#   docker run -v $HOME/build:/home/ompp/build     openmpp/openmpp-build:centos-7 build-openmpp
#   docker run -v $HOME/build:/home/ompp/build     openmpp/openmpp-build:centos-7 build-models
#   docker run -v $HOME/build:/home/ompp/build     openmpp/openmpp-build:centos-7 build-go
#   docker run -v $HOME/build:/home/ompp/build     openmpp/openmpp-build:centos-7 build-r
#   docker run -v $HOME/build:/home/ompp/build     openmpp/openmpp-build:centos-7 build-ui
#   docker run -v $HOME/build:/home/ompp/build     openmpp/openmpp-build:centos-7 build-tar.gz
#   docker run -v $HOME/build:/home/ompp/build -it openmpp/openmpp-build:centos-7 bash
# 

FROM centos:7

# update base image
RUN yum -y update && yum clean all

# install c++17, Open MPI, build utils, source control (git and svn) and SQLite
RUN yum -y install centos-release-scl && \
  yum -y install devtoolset-7-gcc-c++ && \
  yum -y install openmpi && \
  yum -y install openmpi-devel && \
  yum -y install make && \
  yum -y install bison && \
  yum -y install flex && \
  yum -y install git && \
  yum -y install subversion && \
  yum -y install sqlite && \
  yum clean all

# download and install Go and unixODBC
RUN GO_VER=1.11.5; \
  curl -L -o /tmp/go_setup.tar.gz https://dl.google.com/go/go${GO_VER}.linux-amd64.tar.gz && \
  tar -xzf /tmp/go_setup.tar.gz -C /tmp && \
  mv /tmp/go / && \
  rm -rf /tmp/gocache /tmp/tmp && \
  rm /tmp/go_setup.tar.gz

RUN yum -y install unixODBC && \
  yum -y install unixODBC-devel && \
  yum clean all

# download and install R
RUN rpm -Uvh https://download.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
  yum -y install R-core && \
  yum clean all

# download and install node.js
RUN NODE_VER=v10.15.1; \
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
  chmod 755 /scripts/build-ui && \
  chmod 755 /scripts/build-r && \
  chmod 755 /scripts/build-tar-gz && \
  chmod 744 /scripts/build-all

# Done with installation
# set user, work directory and entry point
#
ARG OMPP_UID=9999
ARG OMPP_GID=9999
ARG OMPP_USER=ompp

RUN groupadd -g $OMPP_GID ${OMPP_USER} && \
  useradd --no-log-init -g ${OMPP_USER} -u $OMPP_UID ${OMPP_USER}

USER ${OMPP_USER}:${OMPP_USER}

WORKDIR /home/${OMPP_USER}/build

ENTRYPOINT ["/scripts/entrypoint.sh"]

CMD ["cat", "/scripts/README.txt"]
