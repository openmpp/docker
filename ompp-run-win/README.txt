## Using image

To run openM++ model do:

  docker run .... openmpp/openmpp-run:windows-ltsc2025 MyModel.exe

  Examples:
  docker run -v C:\my\models\bin:C:\ompp openmpp/openmpp-run:windows-ltsc2025 MyModel.exe
  docker run -v C:\my\models\bin:C:\ompp openmpp/openmpp-run:windows-ltsc2025 mpiexec -n 2 MyModel_mpi.exe -OpenM.SubValues 16
  docker run -v C:\my\models\bin:C:\ompp -e OM_ROOT=C:\ompp openmpp/openmpp-run:windows-ltsc2025 MyModel.exe
  
To start command prompt do:
  docker run -v C:\my\models\bin:C:\ompp -it openmpp/openmpp-run:windows-ltsc2025
