# Docker images to build latest openM++ version

Pull the image and use it to build latest openM++ version from source code.
This is a part of [OpenM++](http://www.openmpp.org/) open source microsimulation platform.
Please visit our [wiki](http://www.openmpp.org/wiki/) for more information.

## Supported tags

### `openmpp/openmpp-build:centos-7`

Pull: `docker pull openmpp/openmpp-build:centos-7`

GitHub: [https://github.com/openmpp/docker/tree/master/ompp-build-centos](https://github.com/openmpp/docker/tree/master/ompp-build-centos)

From: `centos:7`

Installed: `gcc-c++17, Open MPI, make, bison, flex, git, SQLite, Go, unixODBC, R, node.js, Perl`

User: `ompp, uid=1999, gid=1999`

### `openmpp/openmpp-build:windows-1809`

Pull: `docker pull openmpp/openmpp-build:windows-1809`

GitHub: [https://github.com/openmpp/docker/tree/master/ompp-build-win](https://github.com/openmpp/docker/tree/master/ompp-build-win)

From: `windows/servercore:1809`

Installed: `Visual C++ 2017 development tools and MSBuild, Microsoft MPI and SDK, git, bison, flex, SQLite, Go, MinGW, R, node.js, Perl, 7zip, curl`

## How to use `openmpp/openmpp-build:centos-7` image

To build openM++ do:
```
docker run .... openmpp/openmpp-build:centos-7 ./build-all
```
Examples:
```
docker run \
  -v $HOME/build:/home/build \
  -e OMPP_USER=build -e OMPP_GROUP=build -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
  openmpp/openmpp-build:centos-7 \
  ./build-all

docker run \
  -v $HOME/build_mpi:/home/build_mpi \
  -e OMPP_USER=build_mpi -e OMPP_GROUP=build_mpi -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
  -e OM_MSG_USE=MPI \
  openmpp/openmpp-build:centos-7 \
  ./build-all

docker run ....user, group, home.... -e MODEL_DIRS=RiskPaths,IDMM      openmpp/openmpp-build:centos-7 ./build-all
docker run ....user, group, home.... -e OM_BUILD_CONFIGS=RELEASE,DEBUG openmpp/openmpp-build:centos-7 ./build-all
docker run ....user, group, home.... -e OM_MSG_USE=MPI                 openmpp/openmpp-build:centos-7 ./build-all
```
Environment variables to control build:
```
OM_BUILD_CONFIGS=RELEASE,DEBUG # default: RELEASE,DEBUG for libraries and RELEASE for models
OM_MSG_USE=MPI                 # default: EMPTY
MODEL_DIRS=modelOne,NewCaseBased,NewTimeBased,NewCaseBased_bilingual,NewTimeBased_bilingual,IDMM,OzProj,OzProjGen,RiskPaths
```
Environment variables to pass your current user, group and home to container:
```
OMPP_USER=ompp   # default: ompp, container user name and HOME
OMPP_GROUP=ompp  # default: ompp, container group name
OMPP_UID=1999    # default: 1999, container user ID
OMPP_GID=1999    # default: 1999, container group ID
```

To build only openM++ libraries and omc compiler do:
```
docker run .... openmpp/openmpp-build:centos-7 ./build-openm
```
Environment variables to control `build-openm`: `OM_BUILD_CONFIGS, OM_MSG_USE`

To build only models do:
```
docker run .... openmpp/openmpp-build:centos-7 ./build-models
```
Environment variables to control `build-models`: `OM_BUILD_CONFIGS, OM_MSG_USE, MODEL_DIRS`

To build openM++ tools do any of:
```
docker run .... openmpp/openmpp-build:centos-7 ./build-go   # Go oms web-service and dbcopy utility
docker run .... openmpp/openmpp-build:centos-7 ./build-r    # openMpp R package
docker run .... openmpp/openmpp-build:centos-7 ./build-ui   # openM++ UI (alpha)
```

To create `openmpp_centos_YYYYMMDD.tar.gz` archive:
```
docker run .... openmpp/openmpp-build:centos-7 ./build-tar-gz
```
Environment variables to control `build-tar-gz`: `OM_MSG_USE, MODEL_DIRS`

To start shell do:
```
docker run .... -it openmpp/openmpp-build:centos-7 bash
```

## How to use `openmpp/openmpp-build:windows-1809` image

To build openM++ do:
```
docker run .... openmpp/openmpp-build:windows-1809 build-all
```
Examples:
```
docker run -v C:\my\build:C:\build openmpp/openmpp-build:windows-1809 build-all
docker run -v C:\my\build:C:\build -e OM_BUILD_PLATFORMS=x64 openmpp/openmpp-build:windows-1809 build-all
docker run -v C:\my\build:C:\build -e MODEL_DIRS=RiskPaths   openmpp/openmpp-build:windows-1809 build-all
```
Environment variables:
```
set OM_BUILD_CONFIGS=Release,Debug (default: Release)
set OM_BUILD_PLATFORMS=Win32,x64   (default: Win32)
set OM_MSG_USE=MPI                 (default: EMPTY)
set MODEL_DIRS=modelOne,NewCaseBased,NewTimeBased,NewCaseBased_bilingual,NewTimeBased_bilingual,IDMM,OzProj,OzProjGen,RiskPaths
```

To build only openM++ libraries and omc compiler do:
```
docker run .... openmpp/openmpp-build:windows-1809 build-openm
```
Environment variables to control `build-openm`: `OM_BUILD_CONFIGS, OM_BUILD_PLATFORMS, OM_MSG_USE`

To build models do:
```
docker run .... openmpp/openmpp-build:windows-1809 build-models
```
Environment variables to control `build-models`: `OM_BUILD_CONFIGS, OM_BUILD_PLATFORMS, OM_MSG_USE, MODEL_DIRS`

To build openM++ tools do any of:
```
docker run .... openmpp/openmpp-build:windows-1809 build-go   # Go oms web-service and dbcopy utility
docker run .... openmpp/openmpp-build:windows-1809 build-r    # openMpp R package
docker run .... openmpp/openmpp-build:windows-1809 build-perl # Perl utilities
docker run .... openmpp/openmpp-build:windows-1809 build-ui   # openM++ UI (alpha)
```

To create `openmpp_win_YYYYMMDD.zip` archive:
```
docker run .... openmpp/openmpp-build:windows-1809 build-zip
```
Environment variables to control `build-zip`: `OM_MSG_USE, MODEL_DIRS`

To open cmd command prompt or Perl command prompt:
```
docker run .... -it openmpp/openmpp-build:windows-1809 cmd
docker run .... -it openmpp/openmpp-build:windows-1809 C:\perl\portableshell
```

## License: MIT

OpenM++ licensed under MIT, image OS and components has it own licensing terms.
