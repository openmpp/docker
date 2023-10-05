# Docker images to run openM++ models

Pull the image and use it to run openM++ models on Windows or Linux as single executable or on MPI cluster.
This is a part of [OpenM++](http://www.openmpp.org/) open source microsimulation platform.
Please visit our [wiki](https://github.com/openmpp/openmpp.github.io/wiki) for more information.

## Supported tags

- `openmpp/openmpp-run:windows-20H2`
- `openmpp/openmpp-run:debian`
- `openmpp/openmpp-run:debian-11`
- `openmpp/openmpp-run:ubuntu`
- `openmpp/openmpp-run:redhat`

### `openmpp/openmpp-run:windows-20H2`

Pull: `docker pull openmpp/openmpp-run:windows-20H2`

GitHub: [https://github.com/openmpp/docker/tree/master/ompp-run-win](https://github.com/openmpp/docker/tree/master/ompp-run-win)

From: `windows/servercore:20H2`

Installed: `Visual C++ re-distributable runtime (VC 2019, 2017, 2015), Microsoft MPI, 7zip, curl`

### `openmpp/openmpp-run:debian`

Pull: `docker pull openmpp/openmpp-run:debian`

GitHub: [https://github.com/openmpp/docker/tree/master/ompp-run-debian](https://github.com/openmpp/docker/tree/master/ompp-run-debian)

From: `debian:stable`

Installed: `Open MPI, SQLite, unixODBC`

### `openmpp/openmpp-run:debian-11`

Pull: `docker pull openmpp/openmpp-run:debian-11`

GitHub: [https://github.com/openmpp/docker/tree/master/ompp-run-debian-11](https://github.com/openmpp/docker/tree/master/ompp-run-debian-11)

From: `debian:stable`

Installed: `Open MPI, SQLite, unixODBC`

### `openmpp/openmpp-run:ubuntu`

Pull: `docker pull openmpp/openmpp-run:ubuntu`

GitHub: [https://github.com/openmpp/docker/tree/master/ompp-run-ubuntu](https://github.com/openmpp/docker/tree/master/ompp-run-ubuntu)

From: `ubuntu:22.04`

Installed: `Open MPI, SQLite, unixODBC`

### `openmpp/openmpp-run:redhat`

Pull: `podman pull openmpp/openmpp-run:redhat`

GitHub: [https://github.com/openmpp/docker/tree/master/ompp-run-redhat](https://github.com/openmpp/docker/tree/master/ompp-run-redhat)

From: `rockylinux/rockylinux:9`

Installed: `Open MPI, SQLite, unixODBC`

## How to use `openmpp/openmpp-run:windows-20H2` image

To run openM++ model do:
```
docker run .... openmpp/openmpp-run:windows-20H2 modelOne.exe
```

Examples:
```
docker run -v C:\my\models\bin:C:\ompp openmpp/openmpp-run:windows-20H2 modelOne.exe
docker run -v C:\my\models\bin:C:\ompp openmpp/openmpp-run:windows-20H2 mpiexec -n 2 modelOne_mpi.exe -OpenM.SubValues 16
docker run -v C:\my\models\bin:C:\ompp -e OM_ROOT=C:\ompp openmpp/openmpp-run:windows-20H2 modelOne.exe
```
  
To start command prompt do:
```
docker run -v C:\my\models\bin:C:\ompp -it openmpp/openmpp-run:windows-20H2 cmd /K
```

## How to use `openmpp/openmpp-run:debian` image

To run openM++ model do:
```
docker run ....options... openmpp/openmpp-run:debian ./modelOne
```

Examples:
```
docker run \
  -v $HOME/models:/home/models \
  -e OMPP_USER=models -e OMPP_GROUP=models -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
  openmpp/openmpp-run:debian \
  ./modelOne

docker run \
  -v $HOME/models:/home/models \
  -e OMPP_USER=models -e OMPP_GROUP=models -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
  openmpp/openmpp-run:debian \
  mpiexec -n 2 ./modelOne_mpi -OpenM.SubValues 16
```

Environment variables to pass your current user and home directory to container:
```
OMPP_USER=ompp   # default: ompp, container user name and HOME
OMPP_GROUP=ompp  # default: ompp, container group name
OMPP_UID=1999    # default: 1999, container user ID
OMPP_GID=1999    # default: 1999, container group ID
```

To start shell do:
```
docker run -it openmpp/openmpp-run:debian bash
```

## How to use `openmpp/openmpp-run:ubuntu` image

To run openM++ model do:
```
sudo docker run ....options... openmpp/openmpp-run:ubuntu ./modelOne
```

Examples:
```
sudo docker run \
  -v $HOME/models:/home/models \
  -e OMPP_USER=models -e OMPP_GROUP=models -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
  openmpp/openmpp-run:ubuntu \
  ./modelOne

sudo docker run \
  -v $HOME/models:/home/models \
  -e OMPP_USER=models -e OMPP_GROUP=models -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
  openmpp/openmpp-run:ubuntu \
  mpiexec -n 2 ./modelOne_mpi -OpenM.SubValues 16
```

Environment variables to pass your current user and home directory to container:
```
OMPP_USER=ompp   # default: ompp, container user name and HOME
OMPP_GROUP=ompp  # default: ompp, container group name
OMPP_UID=1999    # default: 1999, container user ID
OMPP_GID=1999    # default: 1999, container group ID
```

To start shell do:
```
sudo docker run -it openmpp/openmpp-run:ubuntu bash
```

## How to use `openmpp/openmpp-run:redhat` image

To run openM++ model do:
```
podman run ....options... openmpp/openmpp-run:redhat ./modelOne
```

Examples:
```
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
  mpiexec -n 2 ./modelOne_mpi -OpenM.SubValues 16
```

Environment variables to pass your current user and home directory to container:
```
OMPP_USER=ompp   # default: ompp, container user name and HOME dir
```

To start shell do:
```
podman run -it openmpp/openmpp-run:redhat bash
```

## License: MIT

OpenM++ licensed under MIT, image OS and components has it own licensing terms.
