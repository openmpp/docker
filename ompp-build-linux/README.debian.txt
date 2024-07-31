## Using image

To build openM++ do:

  docker run .... openmpp/openmpp-build:debian ./build-all

Examples:
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

  docker run .... -e MODEL_DIRS=RiskPaths,IDMM      openmpp/openmpp-build:debian ./build-all
  docker run .... -e OM_BUILD_CONFIGS=RELEASE,DEBUG openmpp/openmpp-build:debian ./build-all
  docker run .... -e OM_MSG_USE=MPI                 openmpp/openmpp-build:debian ./build-all

### Environment variables:
    OMPP_USER=ompp                 # default: ompp, container user name and HOME
    OMPP_GROUP=ompp                # default: ompp, container group name
    OMPP_UID=1999                  # default: 1999, container user ID
    OMPP_GID=1999                  # default: 1999, container group ID
    OMPP_BUILD_TAG=v1.2.3          # default: build from latest git
    OMPP_LINUX                     # Linux distro name: debian, redhat, ubuntu, default: linux
    OM_BUILD_CONFIGS=RELEASE,DEBUG # default: RELEASE,DEBUG for libraries and RELEASE for models
    OM_MSG_USE=MPI                 # default: EMPTY
    OM_DATE_STAMP=20220817         # default: current date as YYYYMMDD
    MODEL_DIRS=modelOne,NewCaseBased,NewTimeBased,NewCaseBased_bilingual,IDMM,RiskPaths,OzProjGenX,OzProjX

Additional environment variable for build-open and build-models:
  OMPP_CPP_BUILD_TAG=test_branch   # default: build from latest git

If both OMPP_BUILD_TAG and OMPP_CPP_BUILD_TAG specified then OMPP_CPP_BUILD_TAG take precedence

To build openM++ libraries and omc compiler do:

  docker run .... openmpp/openmpp-build:debian ./build-openm
  
  Environment variables to control "build-openm": OM_BUILD_CONFIGS, OM_MSG_USE, OMPP_BUILD_TAG, OMPP_CPP_BUILD_TAG

To build models do:

  docker run .... openmpp/openmpp-build:debian ./build-models
  
  Environment variables to control "build-models": OMPP_LINUX, OMPP_BUILD_TAG, OMPP_CPP_BUILD_TAG, OM_BUILD_CONFIGS, OM_MSG_USE, MODEL_DIRS

To build openM++ tools do any of:

  docker run .... openmpp/openmpp-build:debian ./build-go # Go oms web-service and dbcopy utility
  docker run .... openmpp/openmpp-build:debian ./build-r  # openMpp R package
  docker run .... openmpp/openmpp-build:debian ./build-ui # openM++ UI
  
To create openmpp_debian_YYYYMMDD.tar.gz archive:

  docker run .... openmpp/openmpp-build:debian ./build-tar-gz
  
  Environment variables to control "build-tar-gz": OM_MSG_USE, MODEL_DIRS, OM_DATE_STAMP

To open shell command prompt:

  docker run .... -it openmpp/openmpp-build:debian bash

To build openM++ documentation:

  docker run \
    -v $HOME/build_doc:/home/build_doc \
    -e OMPP_USER=build_doc -e OMPP_GROUP=build_doc -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
    openmpp/openmpp-build:debian \
    ./make-doc

To build openMpp R package:

  docker run \
    -v $HOME/build_r:/home/build_r \
    -e OMPP_USER=build_r -e OMPP_GROUP=build_r -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
    openmpp/openmpp-build:debian \
    ./make-r
