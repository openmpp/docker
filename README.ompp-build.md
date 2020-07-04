# Docker images to build latest openM++ version

Pull the image and use it to build latest openM++ version from source code.
This is a part of [OpenM++](http://www.openmpp.org/) open source microsimulation platform.
Please visit our [wiki](http://www.openmpp.org/wiki/) for more information.

## Supported tags

- `openmpp/openmpp-build:windows-2004`
- `openmpp/openmpp-build:windows-1909`
- `openmpp/openmpp-build:windows-1903`
- `openmpp/openmpp-build:windows-1809`
- `openmpp/openmpp-build:debian`
- `openmpp/openmpp-build:centos-8`
- `openmpp/openmpp-build:centos-7`

### `openmpp/openmpp-build:windows-2004`

Pull: `docker pull openmpp/openmpp-build:windows-2004`

GitHub: [https://github.com/openmpp/docker/tree/master/ompp-build-win](https://github.com/openmpp/docker/tree/master/ompp-build-win)

From: `windows/servercore:2004`

Installed: `Visual C++ 2019 development tools and MSBuild, Microsoft MPI and SDK, git, bison, flex, SQLite, Go, MinGW, R, node.js, Perl, 7zip, curl`

### `openmpp/openmpp-build:debian`

Pull: `docker pull openmpp/openmpp-build:debian`

GitHub: [https://github.com/openmpp/docker/tree/master/ompp-build-debian](https://github.com/openmpp/docker/tree/master/ompp-build-debian)

From: `debian:stable`

Installed: `gcc-c++, Open MPI, make, bison, flex, git, SQLite, Go, unixODBC, R, node.js`

### `openmpp/openmpp-build:centos-8`

Pull: `podman pull openmpp/openmpp-build:centos-8`

GitHub: [https://github.com/openmpp/docker/tree/master/ompp-build-centos](https://github.com/openmpp/docker/tree/master/ompp-build-centos)

From: `centos:8`

Installed: `gcc-c++, Open MPI, make, bison, flex, git, SQLite, Go, unixODBC, R, node.js`

User: `ompp`

## How to use `openmpp/openmpp-build:windows-2004` image

To build openM++ do:
```
docker run .... openmpp/openmpp-build:windows-2004 build-all
```
Examples:
```
docker run --isolation process -v C:\my\build:C:\build openmpp/openmpp-build:windows-2004 build-all
docker run --isolation process -v C:\my\build:C:\build -e OM_BUILD_PLATFORMS=x64 openmpp/openmpp-build:windows-2004 build-all
docker run --isolation process -v C:\my\build:C:\build -e MODEL_DIRS=RiskPaths   openmpp/openmpp-build:windows-2004 build-all
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
docker run .... openmpp/openmpp-build:windows-2004 build-openm
```
Environment variables to control `build-openm`: `OM_BUILD_CONFIGS, OM_BUILD_PLATFORMS, OM_MSG_USE`

To build models do:
```
docker run .... openmpp/openmpp-build:windows-2004 build-models
```
Environment variables to control `build-models`: `OM_BUILD_CONFIGS, OM_BUILD_PLATFORMS, OM_MSG_USE, MODEL_DIRS`

To build openM++ tools do any of:
```
docker run .... openmpp/openmpp-build:windows-2004 build-go   # Go oms web-service and dbcopy utility
docker run .... openmpp/openmpp-build:windows-2004 build-r    # openMpp R package
docker run .... openmpp/openmpp-build:windows-2004 build-perl # Perl utilities
docker run .... openmpp/openmpp-build:windows-2004 build-ui   # openM++ UI
```

To create `openmpp_win_YYYYMMDD.zip` archive:
```
docker run .... openmpp/openmpp-build:windows-2004 build-zip
```
Environment variables to control `build-zip`: `OM_MSG_USE, MODEL_DIRS`

To open cmd command prompt or Perl command prompt:
```
docker run .... -it openmpp/openmpp-build:windows-2004 cmd
docker run .... -it openmpp/openmpp-build:windows-2004 C:\perl\portableshell
```

## How to use `openmpp/openmpp-build:debian` image

To build openM++ do:
```
docker run ....options... openmpp/openmpp-build:debian ./build-all
```
Examples:
```
docker run \
  -v $HOME/build:/home/build \
  -e OMPP_USER=build -e OMPP_GROUP=build -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
  openmpp/openmpp-build:debian \
  ./build-all

docker run \
  -v $HOME/build_mpi:/home/build_mpi \
  -e OMPP_USER=build_mpi -e OMPP_GROUP=build_mpi -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
  -e OM_MSG_USE=MPI \
  openmpp/openmpp-build:debian \
  ./build-all

docker run ....user, group, home.... -e MODEL_DIRS=RiskPaths,IDMM      openmpp/openmpp-build:debian ./build-all
docker run ....user, group, home.... -e OM_BUILD_CONFIGS=RELEASE,DEBUG openmpp/openmpp-build:debian ./build-all
docker run ....user, group, home.... -e OM_MSG_USE=MPI                 openmpp/openmpp-build:debian ./build-all

```
Environment variables to control build:
```
OM_BUILD_CONFIGS=RELEASE,DEBUG # default: RELEASE,DEBUG for libraries and RELEASE for models
OM_MSG_USE=MPI                 # default: EMPTY
MODEL_DIRS=modelOne,NewCaseBased,NewTimeBased,NewCaseBased_bilingual,NewTimeBased_bilingual,IDMM,OzProj,OzProjGen,RiskPaths
```
Environment variables to pass your current user and home directory to container:
```
OMPP_USER=ompp   # default: ompp, container user name and HOME
OMPP_GROUP=ompp  # default: ompp, container group name
OMPP_UID=1999    # default: 1999, container user ID
OMPP_GID=1999    # default: 1999, container group ID
```

To build only openM++ libraries and omc compiler do:
```
docker run .... openmpp/openmpp-build:debian ./build-openm
```
Environment variables to control `build-openm`: `OM_BUILD_CONFIGS, OM_MSG_USE`

To build only models do:
```
docker run .... openmpp/openmpp-build:debian ./build-models
```
Environment variables to control `build-models`: `OM_BUILD_CONFIGS, OM_MSG_USE, MODEL_DIRS`

To build openM++ tools do any of:
```
docker run .... openmpp/openmpp-build:debian ./build-go # Go oms web-service and dbcopy utility
docker run .... openmpp/openmpp-build:debian ./build-r  # openMpp R package
docker run .... openmpp/openmpp-build:debian ./build-ui # openM++ UI
```

To create `openmpp_debian_YYYYMMDD.tar.gz` archive:
```
docker run .... openmpp/openmpp-build:debian ./build-tar-gz
```
Environment variables to control `build-tar-gz`: `OM_MSG_USE, MODEL_DIRS`

To start shell do:
```
docker run .... -it openmpp/openmpp-build:debian bash
```

## How to use `openmpp/openmpp-build:centos-8` image

To build openM++ do:
```
podman run ....options... openmpp/openmpp-build:centos-8 ./build-all
```
Examples:
```
podman run \
  -userns=host \
  -v $HOME/build:/home/build:z \
  -e OMPP_USER=build \
  openmpp/openmpp-build:centos-8 \
  ./build-all

podman run \
  -userns=host \
  -v $HOME/build_mpi:/home/build_mpi:z \
  -e OMPP_USER=build_mpi \
  -e OM_MSG_USE=MPI \
  openmpp/openmpp-build:centos-8 \
  ./build-all

podman run .... -e MODEL_DIRS=RiskPaths,IDMM      openmpp/openmpp-build:centos-8 ./build-all
podman run .... -e OM_BUILD_CONFIGS=RELEASE,DEBUG openmpp/openmpp-build:centos-8 ./build-all
podman run .... -e OM_MSG_USE=MPI                 openmpp/openmpp-build:centos-8 ./build-all
```
Environment variables to control build:
```
OM_BUILD_CONFIGS=RELEASE,DEBUG # default: RELEASE,DEBUG for libraries and RELEASE for models
OM_MSG_USE=MPI                 # default: EMPTY
MODEL_DIRS=modelOne,NewCaseBased,NewTimeBased,NewCaseBased_bilingual,NewTimeBased_bilingual,IDMM,OzProj,OzProjGen,RiskPaths
```
Environment variables to pass your current user and home directory to container:
```
OMPP_USER=ompp   # default: ompp, container user name and HOME dir
```

To build only openM++ libraries and omc compiler do:
```
podman run .... openmpp/openmpp-build:centos-8 ./build-openm
```
Environment variables to control `build-openm`: `OM_BUILD_CONFIGS, OM_MSG_USE`

To build only models do:
```
podman run .... openmpp/openmpp-build:centos-8 ./build-models
```
Environment variables to control `build-models`: `OM_BUILD_CONFIGS, OM_MSG_USE, MODEL_DIRS`

To build openM++ tools do any of:
```
podman run .... openmpp/openmpp-build:centos-8 ./build-go   # Go oms web-service and dbcopy utility
podman run .... openmpp/openmpp-build:centos-8 ./build-r    # openMpp R package
podman run .... openmpp/openmpp-build:centos-8 ./build-ui   # openM++ UI
```

To create `openmpp_centos_YYYYMMDD.tar.gz` archive:
```
podman run .... openmpp/openmpp-build:centos-8 ./build-tar-gz
```
Environment variables to control `build-tar-gz`: `OM_MSG_USE, MODEL_DIRS`

To start shell do:
```
podman run -it openmpp/openmpp-build:centos-8 bash
```

## License: MIT

OpenM++ licensed under MIT, image OS and components has it own licensing terms.

