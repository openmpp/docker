# Docker images to run openM++ models

Pull the image and use it to run openM++ models on Windows or Linux as single executable or on MPI cluster.
This is a part of [OpenM++](http://www.openmpp.org/) open source microsimulation platform.
Please visit our [wiki](http://www.openmpp.org/wiki/) for more information.

## Supported tags

- `openmpp/openmpp-run:windows-1909`
- `openmpp/openmpp-run:windows-1903`
- `openmpp/openmpp-run:windows-1809`
- `openmpp/openmpp-run:centos-8`
- `openmpp/openmpp-run:centos-7`

### `openmpp/openmpp-run:windows-1909`

Pull: `docker pull openmpp/openmpp-run:windows-1909`

GitHub: [https://github.com/openmpp/docker/tree/master/ompp-run-win](https://github.com/openmpp/docker/tree/master/ompp-run-win)

From: `windows/servercore:1909`

Installed: `Visual C++ re-distributable runtime (VC 2019, 2017, 2015), Microsoft MPI, 7zip, curl`

### `openmpp/openmpp-run:centos-8`

Pull: `podman pull openmpp/openmpp-run:centos-8`

GitHub: [https://github.com/openmpp/docker/tree/master/ompp-run-centos](https://github.com/openmpp/docker/tree/master/ompp-run-centos)

From: `centos:8`

Installed: `MPICH, SQLite, unixODBC`

### `openmpp/openmpp-run:centos-7`

Pull: `docker pull openmpp/openmpp-run:centos-7`

GitHub: [https://github.com/openmpp/docker/tree/master/ompp-run-centos](https://github.com/openmpp/docker/tree/master/ompp-run-centos-7)

From: `centos:7`

Installed: `Open MPI, SQLite, unixODBC`

## How to use `openmpp/openmpp-run:windows-1909` image

To run openM++ model do:
```
docker run .... openmpp/openmpp-run:windows-1909 modelOne.exe
```

Examples:
```
docker run --isolation process -v C:\my\models\bin:C:\ompp openmpp/openmpp-run:windows-1909 modelOne.exe
docker run --isolation process -v C:\my\models\bin:C:\ompp openmpp/openmpp-run:windows-1909 mpiexec -n 2 modelOne_mpi.exe -OpenM.SubValues 16
docker run --isolation process -v C:\my\models\bin:C:\ompp -e OM_ROOT=C:\ompp openmpp/openmpp-run:windows-1909 modelOne.exe
```
  
To start command prompt do:
```
docker run -v C:\my\models\bin:C:\ompp -it openmpp/openmpp-run:windows-1909
```

## How to use `openmpp/openmpp-run:centos-8` image

To run openM++ model do:
```
podman run ....options... openmpp/openmpp-run:centos-8 ./modelOne
```

Examples:
```
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
  mpiexec -n 2 ./modelOne_mpi -OpenM.SubValues 16
```

Environment variables to pass your current user and home directory to container:
```
OMPP_USER=ompp   # default: ompp, container user name and HOME dir
```

To start shell do:
```
podman run -it openmpp/openmpp-run:centos-8 bash
```

## How to use `openmpp/openmpp-run:centos-7` image

To run openM++ model do:
```
docker run .... openmpp/openmpp-run:centos-7 ./modelOne
```

Examples:
```
docker run \
  -v $HOME/models:/home/models \
  -e OMPP_USER=models -e OMPP_GROUP=models -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
  openmpp/openmpp-run:centos-7 \
  ./modelOne

docker run \
  -v $HOME/models:/home/models \
  -e OMPP_USER=models -e OMPP_GROUP=models -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
  openmpp/openmpp-run:centos-7 \
  mpiexec -n 2 modelOne_mpi -OpenM.SubValues 16
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

## License: MIT

OpenM++ licensed under MIT, image OS and components has it own licensing terms.
