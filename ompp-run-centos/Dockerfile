# Docker image to run openM++ models on CentOS 7
#
# Examples of build and arguments default values:
#   docker build -t openmpp/openmpp-run:centos-7 .
#   docker build -t openmpp/openmpp-run:centos-7 --build-arg OMPP_USER=ompp .
#   docker build -t openmpp/openmpp-run:centos-7 --build-arg OMPP_UID=1999 .
#   docker build -t openmpp/openmpp-run:centos-7 --build-arg OMPP_GID=1999 .
#
# Examples of run:
#   docker run -v $HOME/models/bin:/home/ompp/models openmpp/openmpp-run:centos-7 ./MyModel
#   docker run -v $HOME/models/bin:/home/ompp/models openmpp/openmpp-run:centos-7 mpiexec -n 2 ./MyModel_mpi -OpenM.SubValues 16
#   docker run -v $HOME/models/bin:/home/ompp/models -it openmpp/openmpp-run:centos-7 bash
# 

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
ARG OMPP_UID=1999
ARG OMPP_GID=1999
ARG OMPP_USER=ompp

RUN groupadd -g $OMPP_GID ${OMPP_USER} && \
  useradd --no-log-init -g ${OMPP_USER} -u $OMPP_UID ${OMPP_USER}

USER ${OMPP_USER}:${OMPP_USER}

WORKDIR /home/${OMPP_USER}/models

ENTRYPOINT ["/scripts/entrypoint.sh"]

# CMD ["cat", "/scripts/README.txt"]

