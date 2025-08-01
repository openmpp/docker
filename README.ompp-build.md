# Docker images to build latest openM++ version

Pull the image and use it to build latest openM++ version from source code.
This is a part of [OpenM++](http://www.openmpp.org/) open source microsimulation platform.
Please visit our [wiki](https://github.com/openmpp/openmpp.github.io/wiki) for more information.

## Supported tags

- `openmpp/openmpp-build:windows-ltsc2025`
- `openmpp/openmpp-build:debian`
- `openmpp/openmpp-build:ubuntu`
- `openmpp/openmpp-build:ubuntu-2204`
- `openmpp/openmpp-build:redhat`

## Unsupported version: `openmpp/openmpp-build:windows-20H2`

### `openmpp/openmpp-build:windows-ltsc2025`

Pull: `docker pull openmpp/openmpp-build:windows-ltsc2025`

GitHub: [https://github.com/openmpp/docker/tree/master/ompp-build-win](https://github.com/openmpp/docker/tree/master/ompp-build-win)

From: `windows/servercore:ltsc2025`

Installed: `Visual C++ 2022 development tools and MSBuild, Microsoft MPI and SDK, git, bison, flex, SQLite, Go, MinGW, R, node.js, Perl, 7zip, curl`

### `openmpp/openmpp-build:debian`

Pull: `docker pull openmpp/openmpp-build:debian`

GitHub: [https://github.com/openmpp/docker/tree/master/ompp-build-linux](https://github.com/openmpp/docker/tree/master/ompp-build-linux)

From: `debian:stable`

Installed: `gcc-c++, Open MPI, make, bison, flex, git, SQLite, Go, unixODBC, R, node.js`

### `openmpp/openmpp-build:ubuntu`

Pull: `docker pull openmpp/openmpp-build:ubuntu`

GitHub: [https://github.com/openmpp/docker/tree/master/ompp-build-linux](https://github.com/openmpp/docker/tree/master/ompp-build-linux)

From: `ubuntu:24.04`

Installed: `gcc-c++, Open MPI, make, bison, flex, git, SQLite, Go, unixODBC, R, node.js`

### `openmpp/openmpp-build:redhat`

Pull: `docker pull openmpp/openmpp-build:redhat`

GitHub: [https://github.com/openmpp/docker/tree/master/ompp-build-linux](https://github.com/openmpp/docker/tree/master/ompp-build-linux)

From: `almalinux:10`

Installed: `gcc-c++, Open MPI, make, bison, flex, git, SQLite, Go, unixODBC, R, node.js`

User: `ompp`

## How to use `openmpp/openmpp-build:windows-ltsc2025` image

To build openM++ do:
```
docker run .... openmpp/openmpp-build:windows-ltsc2025 build-all
```
Examples:
```
docker run -v C:\my\build:C:\build openmpp/openmpp-build:windows-ltsc2025 build-all
docker run -v C:\my\build:C:\build -e OM_BUILD_PLATFORMS=x64 openmpp/openmpp-build:windows-ltsc2025 build-all
docker run -v C:\my\build:C:\build -e MODEL_DIRS=RiskPaths   openmpp/openmpp-build:windows-ltsc2025 build-all
```
Environment variables:
```
set OMPP_BUILD_TAG=v1.2.3          (default: build from latest git)
set OM_BUILD_CONFIGS=Release,Debug (default: Release)
set OM_BUILD_PLATFORMS=Win32,x64   (default: Win32)
set OM_MSG_USE=MPI                 (default: EMPTY)
set OM_DATE_STAMP=20220817         (default: current date as YYYYMMDD)
set MODEL_DIRS=modelOne,NewCaseBased,NewTimeBased,NewCaseBased_bilingual,IDMM,RiskPaths,OzProjGenX,OzProjX,SM1
set OMPP_GIT_URL=https://github.com/openmpp (default)
```
Additional environment variable for build-open and build-model:
````
set OMPP_CPP_BUILD_TAG=test_branch     (default: build from latest git)
````
If both `OMPP_BUILD_TAG` and `OMPP_CPP_BUILD_TAG` specified then `OMPP_CPP_BUILD_TAG` take precedence

To build only openM++ libraries and omc compiler do:
```
docker run .... openmpp/openmpp-build:windows-ltsc2025 build-openm
```
Environment variables to control `build-openm`: `OM_BUILD_CONFIGS, OM_BUILD_PLATFORMS, OM_MSG_USE, OMPP_CPP_BUILD_TAG`

To build models do:
```
docker run .... openmpp/openmpp-build:windows-ltsc2025 build-models
```
Environment variables to control `build-models`: `OM_BUILD_CONFIGS, OM_BUILD_PLATFORMS, OM_MSG_USE, MODEL_DIRS, OMPP_CPP_BUILD_TAG`

To build openM++ tools do any of:
```
docker run .... openmpp/openmpp-build:windows-ltsc2025 build-go   # Go oms web-service and dbcopy utility
docker run .... openmpp/openmpp-build:windows-ltsc2025 build-r    # openMpp R package
docker run .... openmpp/openmpp-build:windows-ltsc2025 build-perl # Perl utilities
docker run .... openmpp/openmpp-build:windows-ltsc2025 build-ui   # openM++ UI
```

To create `openmpp_win_YYYYMMDD.zip` archive:
```
docker run .... openmpp/openmpp-build:windows-ltsc2025 build-zip
```
Environment variables to control `build-zip`: `OM_MSG_USE, MODEL_DIRS, OM_DATE_STAMP`

To open cmd command prompt or Perl command prompt:
```
docker run .... -it openmpp/openmpp-build:windows-ltsc2025 cmd
docker run .... -it openmpp/openmpp-build:windows-ltsc2025 C:\perl32\portableshell
```

## How to use `openmpp/openmpp-build:debian` image

To build openM++ do:
```
docker run ....options... openmpp/openmpp-build:debian ./build-all
```
To build openM++ documentation:
```
docker run ....options... openmpp/openmpp-build:debian ./make-doc
```
Examples:
```
docker run \
  -v $HOME/build:/home/build \
  -e OMPP_USER=build -e OMPP_GROUP=build -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
  -e OMPP_BUILD_TAG=v1.2.3 \
  openmpp/openmpp-build:debian \
  ./build-all

docker run \
  -v $HOME/build_mpi:/home/build_mpi \
  -e OMPP_USER=build_mpi -e OMPP_GROUP=build_mpi -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
  -e OMPP_BUILD_TAG=v1.2.3 \
  -e OM_MSG_USE=MPI \
  openmpp/openmpp-build:debian \
  ./build-all

docker run \
  -v $HOME/build_doc:/home/build_doc \
  -e OMPP_USER=build_doc -e OMPP_GROUP=build_doc -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
  -e OMPP_BUILD_TAG=v1.2.3 \
  openmpp/openmpp-build:debian \
  ./make-doc

docker run \
  -v $HOME/build_r:/home/build_r \
  -e OMPP_USER=build_r -e OMPP_GROUP=build_r -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
  -e OMPP_BUILD_TAG=v1.2.3 \
  openmpp/openmpp-build:debian \
  ./make-r

docker run ....user, group, home.... -e MODEL_DIRS=RiskPaths,IDMM      openmpp/openmpp-build:debian ./build-all
docker run ....user, group, home.... -e OM_BUILD_CONFIGS=RELEASE,DEBUG openmpp/openmpp-build:debian ./build-all
docker run ....user, group, home.... -e OM_MSG_USE=MPI                 openmpp/openmpp-build:debian ./build-all

```
Environment variables to control build:
```
OMPP_BUILD_TAG=v1.2.3          # default: build from latest git
OM_BUILD_CONFIGS=RELEASE,DEBUG # default: RELEASE,DEBUG for libraries and RELEASE for models
OM_MSG_USE=MPI                 # default: EMPTY
OM_DATE_STAMP=20220817         # default: current date as YYYYMMDD
MODEL_DIRS=modelOne,NewCaseBased,NewTimeBased,NewCaseBased_bilingual,IDMM,RiskPaths,OzProjGenX,OzProjX
OMPP_GIT_URL=https://github.com/openmpp # default
```
Additional environment variable for build-open and build-model:
````
OMPP_CPP_BUILD_TAG=test_branch # default: build from latest git
````
If both `OMPP_BUILD_TAG` and `OMPP_CPP_BUILD_TAG` specified then `OMPP_CPP_BUILD_TAG` take precedence

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
Environment variables to control `build-openm`: `OMPP_BUILD_TAG, OM_BUILD_CONFIGS, OM_MSG_USE OMPP_CPP_BUILD_TAG`

To build only models do:
```
docker run .... openmpp/openmpp-build:debian ./build-models
```
Environment variables to control `build-models`: `OM_BUILD_CONFIGS, OM_MSG_USE, MODEL_DIRS, OMPP_CPP_BUILD_TAG`

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
Environment variables to control `build-tar-gz`: `OMPP_BUILD_TAG, OM_MSG_USE, MODEL_DIRS, OM_DATE_STAMP`

To create a new version of `openmpp_doc_YYYYMMDD.zip` documentation archive:
```
docker run .... openmpp/openmpp-build:debian ./make-doc
```

To create a new version of openMpp_x.y.z.tar.gz R package:
```
docker run .... openmpp/openmpp-build:debian ./make-r
```

To start shell do:
```
docker run .... -it openmpp/openmpp-build:debian bash
```

## How to use `openmpp/openmpp-build:ubuntu` image

To build openM++ do:
```
sudo docker run ....options... openmpp/openmpp-build:ubuntu ./build-all
```
Examples:
```
sudo docker run \
  -v $HOME/build:/home/build \
  -e OMPP_USER=build -e OMPP_GROUP=build -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
  -e OMPP_BUILD_TAG=v1.2.3 \
  openmpp/openmpp-build:ubuntu \
  ./build-all

sudo docker run \
  -v $HOME/build_mpi:/home/build_mpi \
  -e OMPP_USER=build_mpi -e OMPP_GROUP=build_mpi -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
  -e OMPP_BUILD_TAG=v1.2.3 \
  -e OM_MSG_USE=MPI \
  openmpp/openmpp-build:ubuntu \
  ./build-all

sudo docker run ....user, group, home.... -e MODEL_DIRS=RiskPaths,IDMM      openmpp/openmpp-build:ubuntu ./build-all
sudo docker run ....user, group, home.... -e OM_BUILD_CONFIGS=RELEASE,DEBUG openmpp/openmpp-build:ubuntu ./build-all
sudo docker run ....user, group, home.... -e OM_MSG_USE=MPI                 openmpp/openmpp-build:ubuntu ./build-all

```
Environment variables to control build:
```
OMPP_BUILD_TAG=v1.2.3          # default: build from latest git
OM_BUILD_CONFIGS=RELEASE,DEBUG # default: RELEASE,DEBUG for libraries and RELEASE for models
OM_MSG_USE=MPI                 # default: EMPTY
OM_DATE_STAMP=20220817         # default: current date as YYYYMMDD
MODEL_DIRS=modelOne,NewCaseBased,NewTimeBased,NewCaseBased_bilingual,IDMM,RiskPaths,OzProjGenX,OzProjX,SM1
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
sudo docker run .... openmpp/openmpp-build:ubuntu ./build-openm
```
Environment variables to control `build-openm`: `OMPP_BUILD_TAG, OM_BUILD_CONFIGS, OM_MSG_USE`

To build only models do:
```
sudo docker run .... openmpp/openmpp-build:ubuntu ./build-models
```
Environment variables to control `build-models`: `OM_BUILD_CONFIGS, OM_MSG_USE, MODEL_DIRS`

To build openM++ tools do any of:
```
sudo docker run .... openmpp/openmpp-build:ubuntu ./build-go # Go oms web-service and dbcopy utility
sudo docker run .... openmpp/openmpp-build:ubuntu ./build-r  # openMpp R package
sudo docker run .... openmpp/openmpp-build:ubuntu ./build-ui # openM++ UI
```

To create `openmpp_ubuntu_YYYYMMDD.tar.gz` archive:
```
sudo docker run .... openmpp/openmpp-build:ubuntu ./build-tar-gz
```
Environment variables to control `build-tar-gz`: `OMPP_BUILD_TAG, OM_MSG_USE, MODEL_DIRS, OM_DATE_STAMP`

To start shell do:
```
sudo docker run .... -it openmpp/openmpp-build:ubuntu bash
```

## How to use `openmpp/openmpp-build:redhat` image

To build openM++ do:
```
podman run ....options... openmpp/openmpp-build:redhat ./build-all
```
Examples:
```
podman run \
  -userns=host \
  -v $HOME/build:/home/build:z \
  -e OMPP_USER=build \
  -e OMPP_BUILD_TAG=v1.2.3 \
  openmpp/openmpp-build:redhat \
  ./build-all

podman run \
  -userns=host \
  -v $HOME/build_mpi:/home/build_mpi:z \
  -e OMPP_USER=build_mpi \
  -e OMPP_BUILD_TAG=v1.2.3 \
  -e OM_MSG_USE=MPI \
  openmpp/openmpp-build:redhat \
  ./build-all

podman run .... -e MODEL_DIRS=RiskPaths,IDMM      openmpp/openmpp-build:redhat ./build-all
podman run .... -e OM_BUILD_CONFIGS=RELEASE,DEBUG openmpp/openmpp-build:redhat ./build-all
podman run .... -e OM_MSG_USE=MPI                 openmpp/openmpp-build:redhat ./build-all
```
Environment variables to control build:
```
OMPP_BUILD_TAG=v1.2.3          # default: build from latest git
OM_BUILD_CONFIGS=RELEASE,DEBUG # default: RELEASE,DEBUG for libraries and RELEASE for models
OM_MSG_USE=MPI                 # default: EMPTY
OM_DATE_STAMP=20220817         # default: current date as YYYYMMDD
MODEL_DIRS=modelOne,NewCaseBased,NewTimeBased,NewCaseBased_bilingual,IDMM,RiskPaths,OzProjGenX,OzProjX,SM1
```
Environment variables to pass your current user and home directory to container:
```
OMPP_USER=ompp   # default: ompp, container user name and HOME dir
```

To build only openM++ libraries and omc compiler do:
```
podman run .... openmpp/openmpp-build:redhat ./build-openm
```
Environment variables to control `build-openm`: `OMPP_BUILD_TAG, OM_BUILD_CONFIGS, OM_MSG_USE`

To build only models do:
```
podman run .... openmpp/openmpp-build:redhat ./build-models
```
Environment variables to control `build-models`: `OM_BUILD_CONFIGS, OM_MSG_USE, MODEL_DIRS`

To build openM++ tools do any of:
```
podman run .... openmpp/openmpp-build:redhat ./build-go   # Go oms web-service and dbcopy utility
podman run .... openmpp/openmpp-build:redhat ./build-r    # openMpp R package
podman run .... openmpp/openmpp-build:redhat ./build-ui   # openM++ UI
```

To create `openmpp_redhat_YYYYMMDD.tar.gz` archive:
```
podman run .... openmpp/openmpp-build:redhat ./build-tar-gz
```
Environment variables to control `build-tar-gz`: `OMPP_BUILD_TAG, OM_MSG_USE, MODEL_DIRS, OM_DATE_STAMP`

To start shell do:
```
podman run -it openmpp/openmpp-build:redhat bash
```

## License: MIT

OpenM++ licensed under MIT, image OS and components has it own licensing terms.

