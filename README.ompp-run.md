# Docker images to run openM++ models

Pull the image and use it to run openM++ models on Windows or Linux as single executable or on MPI cluster.
This is a part of [OpenM++](http://www.openmpp.org/) open source microsimulation platform.
Please visit our [wiki](http://www.openmpp.org/wiki/) for more information.

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

Installed: `Visual C++ 2015 re-distributable runtime, Microsoft MPI, 7zip, curl`

## How to use `openmpp/openmpp-run:centos-7` image

To run openM++ model do:
```
docker run .... openmpp/openmpp-run:centos-7 ./MyModel
```

Examples:
```
docker run \
  -v $HOME/models:/home/models \
  -e OMPP_USER=models -e OMPP_GROUP=models -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
  openmpp/openmpp-run:centos-7 \
  ./MyModel

docker run \
  -v $HOME/models:/home/models \
  -e OMPP_USER=models -e OMPP_GROUP=models -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
  openmpp/openmpp-run:centos-7 \
  mpiexec -n 2 MyModel_mpi -OpenM.SubValues 16
```

Environment variables to pass your current user, group and home to container:
```
OMPP_USER=ompp   # default: ompp, container user name and HOME
OMPP_GROUP=ompp  # default: ompp, container group name
OMPP_UID=1999    # default: 1999, container user ID
OMPP_GID=1999    # default: 1999, container group ID
```

To start shell do:
```
docker run -v $HOME/models/bin:/home/ompp/models -it openmpp/openmpp-run:centos-7 bash
```

## How to use `openmpp/openmpp-run:windows-1809` image

To run openM++ model do:
```
docker run .... openmpp/openmpp-run:windows-1809 MyModel.exe
```

Examples:
```
docker run -v C:\my\models\bin:C:\ompp openmpp/openmpp-run:windows-1809 MyModel.exe
docker run -v C:\my\models\bin:C:\ompp openmpp/openmpp-run:windows-1809 mpiexec -n 2 MyModel_mpi.exe -OpenM.SubValues 16
docker run -v C:\my\models\bin:C:\ompp -e OM_ROOT=C:\ompp openmpp/openmpp-run:windows-1809 MyModel.exe
```
  
To start command prompt do:
```
docker run -v C:\my\models\bin:C:\ompp -it openmpp/openmpp-run:windows-1809
```

## License: MIT

OpenM++ licensed under MIT, image OS and components has it own licensing terms.
