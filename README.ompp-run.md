# Docker images to run openM++ models

This is a part of [OpenM++](http://www.openmpp.org/) open source microsimulation platform.
It contains Docker images to run microsimulation models on Windows or Linux as single executable or on MPI cluster.
Please visit our [wiki](http://www.openmpp.org/wiki/) to find more.

## Supported tags

### `openmpp/openmpp-run:centos-7`

Pull: `docker pull openmpp/openmpp-run:centos-7`

GitHub: [https://github.com/openmpp/docker/tree/master/ompp-run-centos](https://github.com/openmpp/docker/tree/master/ompp-run-centos)

From: `centos:7`

Installed: `Open MPI, SQLite, unixODBC`

### `openmpp/openmpp-run:windows-1809`

Pull: `docker pull openmpp/openmpp-run:windows-1809`

GitHub: [https://github.com/openmpp/docker/tree/master/ompp-run-win](https://github.com/openmpp/docker/tree/master/ompp-run-win)

From: `windows/servercore:1809`

Installed: `VisualC 2015 re-distributable runtime, Microsoft MPI, 7zip, curl`

## Using `openmpp/openmpp-run:centos-7` image

To run openM++ model do:
```
docker run .... openmpp/openmpp-run:centos-7 ./MyModel
```

Examples:
 ```
docker run -v $HOME/models/bin:/home/ompp/models openmpp/openmpp-run:centos-7 ./MyModel
docker run -v $HOME/models/bin:/home/ompp/models openmpp/openmpp-run:centos-7 mpiexec -n 2 MyModel_mpi -OpenM.SubValues 16
docker run -v $HOME/models/bin:/home/ompp/models -e OM_ROOT=/home/ompp openmpp/openmpp-run:centos-7 ./MyModel
```

To start shell do:
```
docker run -v $HOME/models/bin:/home/ompp/models -it openmpp/openmpp-run:centos-7 bash
```

## Using `openmpp/openmpp-run:windows-1809` image

To run openM++ model do:
```
docker run .... openmpp/openmpp-run:windows-1809 MyModel.exe
```

Examples:
```
docker run --isolation process -v C:\my\models\bin:C:\ompp openmpp/openmpp-run:windows-1809 MyModel.exe
docker run --isolation process -v C:\my\models\bin:C:\ompp openmpp/openmpp-run:windows-1809 mpiexec -n 2 MyModel_mpi.exe -OpenM.SubValues 16
docker run --isolation process -v C:\my\models\bin:C:\ompp -e OM_ROOT=C:\ompp openmpp/openmpp-run:windows-1809 MyModel.exe
```
  
To start command prompt do:
```
docker run --isolation process -v C:\my\models\bin:C:\ompp -it openmpp/openmpp-run:windows-1809
```

## License: MIT

OpenM++ licensed under MIT, image OS and components has it own licensing terms.
