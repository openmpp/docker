## Using image

To run openM++ model do:

  docker run .... openmpp/openmpp-run:centos-7 ./MyModel
  
  Examples:
  docker run -v $HOME/models/bin:/home/ompp/models openmpp/openmpp-run:centos-7 ./MyModel
  docker run -v $HOME/models/bin:/home/ompp/models openmpp/openmpp-run:centos-7 mpiexec -n 2 MyModel_mpi -OpenM.SubValues 16
  docker run -v $HOME/models/bin:/home/ompp/models -e OM_ROOT=/home/ompp openmpp/openmpp-run:centos-7 ./MyModel
  
To start shell do:
  docker run -v $HOME/models/bin:/home/ompp/models -it openmpp/openmpp-run:centos-7 bash
