# Docker image to run openM++ models on CentOS 7
#
# Examples of build and arguments default values:
#   docker build -t openmpp/openmpp-run:centos-7 .
#   docker build -t openmpp/openmpp-run:centos-7 --build-arg OMPP_USER=ompp .
#   docker build -t openmpp/openmpp-run:centos-7 --build-arg OMPP_GROUP=ompp .
#   docker build -t openmpp/openmpp-run:centos-7 --build-arg OMPP_UID=1999 .
#   docker build -t openmpp/openmpp-run:centos-7 --build-arg OMPP_GID=1999 .
#
# Examples of run:
#   docker run \
#     -v $HOME/models:/home/models \
#     -e OMPP_USER=models -e OMPP_GROUP=models -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
#     openmpp/openmpp-run:centos-7 \
#     ./MyModel
#
#   docker run \
#     -v $HOME/models:/home/models \
#     -e OMPP_USER=models -e OMPP_GROUP=models -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
#     openmpp/openmpp-run:centos-7 \
#     mpiexec -n 2 MyModel_mpi -OpenM.SubValues 16
#
#   docker run -it openmpp/openmpp-run:centos-7 bash
#
#   docker run \
#     -v $HOME:/home/${USER} \
#     -e OMPP_USER=${USER} -e OMPP_GROUP=`id -gn` -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
#     -it openmpp/openmpp-run:centos-7 \
#     bash

FROM centos:7

# update base image
RUN yum -y update && yum clean all

# install Open MPI and SQLite
RUN yum -y install openmpi && \
  yum -y install sqlite && \
  yum clean all

# download and install unixODBC
RUN yum -y install unixODBC && \
  yum clean all

# copy entry point and build scripts
COPY entrypoint.sh /scripts/

RUN chmod 755 /scripts/entrypoint.sh

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
# WORKDIR /home/${OMPP_USER}/models

ENTRYPOINT ["/scripts/entrypoint.sh"]

# CMD ["cat", "/scripts/README.txt"]

