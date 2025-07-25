## Using image

To build openM++ do:

  docker run .... openmpp/openmpp-build:ubuntu-2204 ./build-all

Examples:
  docker run \
    -v $HOME/build:/home/build \
    -e OMPP_USER=build -e OMPP_GROUP=build -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
    -e OMPP_BUILD_TAG=v1.2.3 \
    openmpp/openmpp-build:ubuntu-2204 \
    ./build-all

  docker run \
    -v $HOME/build_mpi:/home/build_mpi \
    -e OMPP_USER=build_mpi -e OMPP_GROUP=build_mpi -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
    -e OMPP_BUILD_TAG=v1.2.3 \
    -e OM_MSG_USE=MPI \
    openmpp/openmpp-build:ubuntu-2204 \
    ./build-all

  docker run .... -e MODEL_DIRS=RiskPaths,IDMM      openmpp/openmpp-build:ubuntu-2204 ./build-all
  docker run .... -e OM_BUILD_CONFIGS=RELEASE,DEBUG openmpp/openmpp-build:ubuntu-2204 ./build-all
  docker run .... -e OM_MSG_USE=MPI                 openmpp/openmpp-build:ubuntu-2204 ./build-all

### Environment variables:
    OMPP_USER=ompp                 # default: ompp, container user name and HOME
    OMPP_GROUP=ompp                # default: ompp, container group name
    OMPP_UID=1999                  # default: 1999, container user ID
    OMPP_GID=1999                  # default: 1999, container group ID
    OMPP_BUILD_TAG=v1.2.3          # default: build from latest git
    OMPP_LINUX                     # Linux distro name: debian, redhat, ubuntu, default: linux
    OMPP_GIT_URL                   # default: https://github.com/openmpp
    OM_BUILD_CONFIGS=RELEASE,DEBUG # default: RELEASE,DEBUG for libraries and RELEASE for models
    OM_MSG_USE=MPI                 # default: EMPTY
    OM_DATE_STAMP=20220817         # default: current date as YYYYMMDD
    MODEL_DIRS=modelOne,NewCaseBased,NewTimeBased,NewCaseBased_bilingual,IDMM,RiskPaths,OzProjGenX,OzProjX

Additional environment variable for build-open and build-models:
  OMPP_CPP_BUILD_TAG=test_branch   # default: build from latest git

If both OMPP_BUILD_TAG and OMPP_CPP_BUILD_TAG specified then OMPP_CPP_BUILD_TAG take precedence

To build openM++ libraries and omc compiler do:

  docker run .... openmpp/openmpp-build:ubuntu-2204 ./build-openm
  
  Environment variables to control "build-openm": OM_BUILD_CONFIGS, OM_MSG_USE, OMPP_BUILD_TAG, OMPP_CPP_BUILD_TAG

To build models do:

  docker run .... openmpp/openmpp-build:ubuntu-2204 ./build-models
  
  Environment variables to control "build-models": OMPP_LINUX, OMPP_BUILD_TAG, OMPP_CPP_BUILD_TAG, OM_BUILD_CONFIGS, OM_MSG_USE, MODEL_DIRS

To build openM++ tools do any of:

  docker run .... openmpp/openmpp-build:ubuntu-2204 ./build-go # Go oms web-service and dbcopy utility
  docker run .... openmpp/openmpp-build:ubuntu-2204 ./build-r  # openMpp R package
  docker run .... openmpp/openmpp-build:ubuntu-2204 ./build-ui # openM++ UI
  
To create openmpp_ubuntu-2204_YYYYMMDD.tar.gz archive:

  docker run .... openmpp/openmpp-build:ubuntu-2204 ./build-tar-gz
  
  Environment variables to control "build-tar-gz": OM_MSG_USE, MODEL_DIRS, OM_DATE_STAMP

To open shell command prompt:

  docker run .... -it openmpp/openmpp-build:ubuntu-2204 bash
