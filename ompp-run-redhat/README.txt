## Using image

To run openM++ model do:

  podman run .... openmpp/openmpp-run:redhat ./modelOne
  
Examples:
  podman run \
    -userns=host \
    -v $HOME/models:/home/models:z \
    -e OMPP_USER=models \
    openmpp/openmpp-run:redhat \
    ./modelOne

  podman run \
    -userns=host \
    -v $HOME/models:/home/models:z \
    -e OMPP_USER=models \
    openmpp/openmpp-run:redhat \
    mpiexec --allow-run-as-root -n 2 MyModel_mpi -OpenM.SubValues 16

To start shell do:

  podman run -it openmpp/openmpp-run:redhat bash

Environment variables:
  OMPP_USER=ompp   # default: ompp, container user name and HOME
