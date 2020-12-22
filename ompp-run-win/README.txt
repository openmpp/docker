## Using image

To run openM++ model do:

  docker run .... openmpp/openmpp-run:windows-20H2 MyModel.exe

  Examples:
  docker run --isolation process -v C:\my\models\bin:C:\ompp openmpp/openmpp-run:windows-20H2 MyModel.exe
  docker run --isolation process -v C:\my\models\bin:C:\ompp openmpp/openmpp-run:windows-20H2 mpiexec -n 2 MyModel_mpi.exe -OpenM.SubValues 16
  docker run --isolation process -v C:\my\models\bin:C:\ompp -e OM_ROOT=C:\ompp openmpp/openmpp-run:windows-20H2 MyModel.exe
  
To start command prompt do:
  docker run -v C:\my\models\bin:C:\ompp -it openmpp/openmpp-run:windows-20H2
