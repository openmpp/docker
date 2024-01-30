# Docker image to run openM++ models on Rocky Linux 9
#
# Examples of build and arguments default values:
#   podman build -t openmpp/openmpp-run:redhat-9 .
#   podman build -t openmpp/openmpp-run:redhat-9 --build-arg OMPP_USER=ompp .
#
# Examples of run:
#   podman run \
#     -userns=host \
#     -v $HOME/models:/home/models:z \
#     -e OMPP_USER=models \
#     openmpp/openmpp-run:redhat-9 \
#     ./modelOne
#
#   podman run \
#     -userns=host \
#     -v $HOME/models:/home/models:z \
#     -e OMPP_USER=models \
#     openmpp/openmpp-run:redhat-9 \
#     mpiexec --allow-run-as-root -n 2 modelOne_mpi -OpenM.SubValues 16
#
#   podman run -it openmpp/openmpp-run:redhat-9 bash
#

FROM rockylinux/rockylinux:9

# update base image
RUN dnf -y update && dnf clean all

# install Open MPI and SQLite
#
# 2024-01-30:
# remove SQLite update to the current  sqlite-libs-3.34.1-7
# openMPI broken dependency,it require sqlite-libs-3.34.1-6
RUN dnf -y --setopt=tsflags=nodocs install openmpi

# install Open MPI and SQLite
# RUN dnf -y --setopt=tsflags=nodocs install openmpi && \
#  dnf -y --setopt=tsflags=nodocs install sqlite

# download and install unixODBC (optional)
RUN dnf -y --setopt=tsflags=nodocs install unixODBC

# cleanup
RUN dnf clean all

# set local openM++ timezone
RUN rm -f /etc/localtime && \
  ln -s /usr/share/zoneinfo/America/Toronto /etc/localtime

# copy entry point and build scripts
COPY entrypoint.sh \
  README.txt \
  /scripts/

RUN chmod 755 /scripts/entrypoint.sh && \
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

