## Using image

To build openM++ do:

  sudo docker run .... openmpp/openmpp-build:ubuntu ./build-all
  
Examples:
  sudo docker run \
    -v $HOME/build:/home/build \
    -e OMPP_USER=build -e OMPP_GROUP=build -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
    openmpp/openmpp-build:ubuntu \
    ./build-all

  sudo docker run \
    -v $HOME/build_mpi:/home/build_mpi \
    -e OMPP_USER=build_mpi -e OMPP_GROUP=build_mpi -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
    -e OM_MSG_USE=MPI \
    openmpp/openmpp-build:ubuntu \
    ./build-all

  docker run ....user, group, home.... -e MODEL_DIRS=RiskPaths,IDMM      openmpp/openmpp-build:ubuntu ./build-all
  docker run ....user, group, home.... -e OM_BUILD_CONFIGS=RELEASE,DEBUG openmpp/openmpp-build:ubuntu ./build-all
  docker run ....user, group, home.... -e OM_MSG_USE=MPI                 openmpp/openmpp-build:ubuntu ./build-all

Environment variables:
  OMPP_USER=ompp                 # default: ompp, container user name and HOME
  OMPP_GROUP=ompp                # default: ompp, container group name
  OMPP_UID=1999                  # default: 1999, container user ID
  OMPP_GID=1999                  # default: 1999, container group ID
  OM_BUILD_CONFIGS=RELEASE,DEBUG # default: RELEASE,DEBUG for libraries and RELEASE for models
  OM_MSG_USE=MPI                 # default: EMPTY
  MODEL_DIRS=modelOne,NewCaseBased,NewTimeBased,NewCaseBased_bilingual,IDMM,RiskPaths

To build openM++ libraries and omc compiler do:

  sudo docker run .... openmpp/openmpp-build:ubuntu ./build-openm
  
  Environment variables to control "build-openm": OM_BUILD_CONFIGS, OM_MSG_USE

To build models do:

  sudo docker run .... openmpp/openmpp-build:ubuntu ./build-models
  
  Environment variables to control "build-models": OM_BUILD_CONFIGS, OM_MSG_USE, MODEL_DIRS

To build openM++ tools do any of:

  sudo docker run .... openmpp/openmpp-build:ubuntu ./build-go # Go oms web-service and dbcopy utility
  sudo docker run .... openmpp/openmpp-build:ubuntu ./build-r  # openMpp R package
  sudo docker run .... openmpp/openmpp-build:ubuntu ./build-ui # openM++ UI
  
To create openmpp_ubuntu_YYYYMMDD.tar.gz archive:

  sudo docker run .... openmpp/openmpp-build:ubuntu ./build-tar-gz
  
  Environment variables to control "build-tar-gz": OM_MSG_USE, MODEL_DIRS

To open shell command prompt:

  sudo docker run .... -it openmpp/openmpp-build:ubuntu bash
