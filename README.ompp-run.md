# Docker images to run openM++ models

Pull the image and use it to run openM++ models on Windows or Linux as single executable or on MPI cluster.
This is a part of [OpenM++](http://www.openmpp.org/) open source microsimulation platform.
Please visit our [wiki](http://www.openmpp.org/wiki/) for more information.

## Supported tags

- `openmpp/openmpp-run:windows-2004`
- `openmpp/openmpp-run:windows-1909`
- `openmpp/openmpp-run:windows-1903`
- `openmpp/openmpp-run:windows-1809`
- `openmpp/openmpp-run:centos-8`
- `openmpp/openmpp-run:centos-7`

### `openmpp/openmpp-run:windows-2004`

Pull: `docker pull openmpp/openmpp-run:windows-2004`

GitHub: [https://github.com/openmpp/docker/tree/master/ompp-run-win](https://github.com/openmpp/docker/tree/master/ompp-run-win)

From: `windows/servercore:2004`

Installed: `Visual C++ re-distributable runtime (VC 2019, 2017, 2015), Microsoft MPI, 7zip, curl`

### `openmpp/openmpp-run:centos-8`

Pull: `podman pull openmpp/openmpp-run:centos-8`

GitHub: [https://github.com/openmpp/docker/tree/master/ompp-run-centos](https://github.com/openmpp/docker/tree/master/ompp-run-centos)

From: `centos:8`

Installed: `Open MPI, SQLite, unixODBC`

## How to use `openmpp/openmpp-run:windows-2004` image

To run openM++ model do:
```
docker run .... openmpp/openmpp-run:windows-2004 modelOne.exe
```

Examples:
```
docker run --isolation process -v C:\my\models\bin:C:\ompp openmpp/openmpp-run:windows-2004 modelOne.exe
docker run --isolation process -v C:\my\models\bin:C:\ompp openmpp/openmpp-run:windows-2004 mpiexec -n 2 modelOne_mpi.exe -OpenM.SubValues 16
docker run --isolation process -v C:\my\models\bin:C:\ompp -e OM_ROOT=C:\ompp openmpp/openmpp-run:windows-2004 modelOne.exe
```
  
To start command prompt do:
```
docker run -v C:\my\models\bin:C:\ompp -it openmpp/openmpp-run:windows-2004
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

## License: MIT

OpenM++ licensed under MIT, image OS and components has it own licensing terms.
