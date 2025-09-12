# Docker image to run openM++ models on Alma Linux 10
#
# Examples of build and arguments default values:
#   podman build -t openmpp/openmpp-run:redhat .
#   podman build -t openmpp/openmpp-run:redhat --build-arg OMPP_USER=ompp .
#
# Examples of run:
#   podman run \
#     -userns=host \
#     -v $HOME/models:/home/models:z \
#     -e OMPP_USER=models \
#     openmpp/openmpp-run:redhat \
#     ./modelOne
#
#   podman run \
#     -userns=host \
#     -v $HOME/models:/home/models:z \
#     -e OMPP_USER=models \
#     openmpp/openmpp-run:redhat \
#     mpiexec --allow-run-as-root -n 2 modelOne_mpi -OpenM.SubValues 16
#
#   podman run -it openmpp/openmpp-run:redhat bash
#

FROM almalinux:10

# update base image
RUN dnf -y update && dnf clean all

# install Open MPI
RUN dnf -y --setopt=tsflags=nodocs install openmpi

# (optional) install SQLite and unixODBC
RUN dnf -y --setopt=tsflags=nodocs install sqlite && \
    dnf -y --setopt=tsflags=nodocs install unixODBC

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

