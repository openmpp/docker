## Using image

To build openM++ do:

  docker run .... openmpp/openmpp-build:centos-7 ./build-all
  
Examples:
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

Environment variables:
  OMPP_USER=ompp                 # default: ompp, container user name and HOME
  OMPP_GROUP=ompp                # default: ompp, container group name
  OMPP_UID=1999                  # default: 1999, container user ID
  OMPP_GID=1999                  # default: 1999, container group ID
  OM_BUILD_CONFIGS=RELEASE,DEBUG # default: RELEASE,DEBUG for libraries and RELEASE for models
  OM_MSG_USE=MPI                 # default: EMPTY
  MODEL_DIRS=modelOne,NewCaseBased,NewTimeBased,NewCaseBased_bilingual,NewTimeBased_bilingual,IDMM,OzProj,OzProjGen,RiskPaths

To build openM++ libraries and omc compiler do:

  docker run .... openmpp/openmpp-build:centos-7 ./build-openm
  
  Environment variables to control "build-openm": OM_BUILD_CONFIGS, OM_MSG_USE

To build models do:

  docker run .... openmpp/openmpp-build:centos-7 ./build-models
  
  Environment variables to control "build-models": OM_BUILD_CONFIGS, OM_MSG_USE, MODEL_DIRS

To build openM++ tools do any of:

  docker run .... openmpp/openmpp-build:centos-7 ./build-go     # Go oms web-service and dbcopy utility
  docker run .... openmpp/openmpp-build:centos-7 ./build-r      # openMpp R package
  docker run .... openmpp/openmpp-build:centos-7 ./build-python # openM++ Python examples
  docker run .... openmpp/openmpp-build:centos-7 ./build-ui     # openM++ UI
  
To create openmpp_centos_YYYYMMDD.tar.gz archive:

  docker run .... openmpp/openmpp-build:centos-7 ./build-tar-gz
  
  Environment variables to control "build-tar-gz": OM_MSG_USE, MODEL_DIRS

To open shell command prompt:

  docker run .... -it openmpp/openmpp-build:centos-7 bash
