## Using image

To run openM++ model do:

  podman run .... openmpp/openmpp-run:centos-8 ./modelOne
  
Examples:
  podman run \
    -userns=host \
    -v $HOME/models:/home/models:z \
    -e OMPP_USER=models \
    openmpp/openmpp-run:centos-8 \
    ./modelOne

  podman run \
    -userns=host \
    -v $HOME/models:/home/models:z \
    -e OMPP_USER=models \
    openmpp/openmpp-run:centos-8 \
    mpiexec --allow-run-as-root -n 2 MyModel_mpi -OpenM.SubValues 16

To start shell do:

  podman run -it openmpp/openmpp-run:centos-8 bash

Environment variables:
  OMPP_USER=ompp   # default: ompp, container user name and HOME
