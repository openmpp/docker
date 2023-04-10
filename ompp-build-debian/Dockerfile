# Docker image to build openM++ latest version on Debian stable
# It is also can make latest version of openM++ documentation
#
# Examples of build and arguments default values:
#   docker build -t openmpp/openmpp-build:debian .
#   docker build -t openmpp/openmpp-build:debian --build-arg OMPP_USER=ompp .
#   docker build -t openmpp/openmpp-build:debian --build-arg OMPP_GROUP=ompp .
#   docker build -t openmpp/openmpp-build:debian --build-arg OMPP_UID=1999 .
#   docker build -t openmpp/openmpp-build:debian --build-arg OMPP_GID=1999 .
#
# Examples of run, mapping your login user, group and home to container:
#
#   docker run \
#     -v $HOME/build:/home/build \
#     -e OMPP_USER=build -e OMPP_GROUP=build -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
#     openmpp/openmpp-build:debian \
#     ./build-all
#
#   docker run \
#     -v $HOME/build_mpi:/home/build_mpi \
#     -e OMPP_USER=build_mpi -e OMPP_GROUP=build_mpi -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
#     -e OM_MSG_USE=MPI \
#     openmpp/openmpp-build:debian \
#     ./build-all
#
#   docker run ....user, group, home.... -e OM_MSG_USE=MPI     openmpp/openmpp-build:debian ./build-openm
#   docker run ....user, group, home.... -e MODEL_DIRS=MyModel openmpp/openmpp-build:debian ./build-models
#   docker run ....user, group, home.... openmpp/openmpp-build:debian ./build-go
#   docker run ....user, group, home.... openmpp/openmpp-build:debian ./build-r
#   docker run ....user, group, home.... openmpp/openmpp-build:debian ./build-ui
#   docker run ....user, group, home.... openmpp/openmpp-build:debian ./build-tar-gz
#
#   docker run .... -it openmpp/openmpp-build:debian bash
#
# To build openM++ documentation:
#
#   docker run \
#     -v $HOME/build_doc:/home/build_doc \
#     -e OMPP_USER=build_doc -e OMPP_GROUP=build_doc -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
#     openmpp/openmpp-build:debian \
#     ./make-doc
#
# To build openMpp R package:
#
#   docker run \
#     -v $HOME/build_r:/home/build_r \
#     -e OMPP_USER=build_r -e OMPP_GROUP=build_r -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
#     openmpp/openmpp-build:debian \
#     ./make-r
#

FROM debian:stable

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
RUN GO_VER=1.20.3; \
  curl -L -o /tmp/go_setup.tar.gz https://dl.google.com/go/go${GO_VER}.linux-amd64.tar.gz && \
  tar -xzf /tmp/go_setup.tar.gz -C /tmp && \
  mv /tmp/go / && \
  rm -rf /tmp/gocache /tmp/tmp && \
  rm /tmp/go_setup.tar.gz

# download and install unixODBC (optional)
RUN apt-get install -y unixodbc unixodbc-dev

# download and install R
RUN apt-get install -y r-base-core

# cleanup
RUN apt-get autoclean

# for documentation build: download and install Doxygen
RUN apt-get install -y doxygen graphviz

# for documentation build: download and install wkhtmltopdf
RUN WKHPDF_VER=0.12.6-1; \
  curl -L -o /tmp/wkhtmltopdf_setup.deb https://github.com/wkhtmltopdf/packaging/releases/download/${WKHPDF_VER}/wkhtmltox_${WKHPDF_VER}.buster_amd64.deb && \
  apt install -y /tmp/wkhtmltopdf_setup.deb && \
  rm /tmp/wkhtmltopdf_setup.deb

# download and install node.js
RUN NODE_VER=v18.13.0; \
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
  make-doc \
  make-r \
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
  chmod 755 /scripts/make-doc && \
  chmod 755 /scripts/make-r && \
  chmod 744 /scripts/model.ini && \
  chmod 744 /scripts/README.txt

# describe image
#
LABEL name=openmpp/openmpp-build:debian
LABEL os=Linux
LABEL license=MIT
LABEL description="OpenM++ build environemnt: g++, make, OpenMPI, git, SQLite, bison, flex, Go, R, node.js"

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
