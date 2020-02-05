## Using image

To build openM++ do:

  podman run .... openmpp/openmpp-build:centos-8 ./build-all
  
Examples:
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

Environment variables:
  OMPP_USER=ompp                 # default: ompp, container user name and HOME
  OM_BUILD_CONFIGS=RELEASE,DEBUG # default: RELEASE,DEBUG for libraries and RELEASE for models
  OM_MSG_USE=MPI                 # default: EMPTY
  MODEL_DIRS=modelOne,NewCaseBased,NewTimeBased,NewCaseBased_bilingual,NewTimeBased_bilingual,IDMM,OzProj,OzProjGen,RiskPaths

To build openM++ libraries and omc compiler do:

  podman run .... openmpp/openmpp-build:centos-8 ./build-openm
  
  Environment variables to control "build-openm": OM_BUILD_CONFIGS, OM_MSG_USE

To build models do:

  podman run .... openmpp/openmpp-build:centos-8 ./build-models
  
  Environment variables to control "build-models": OM_BUILD_CONFIGS, OM_MSG_USE, MODEL_DIRS

To build openM++ tools do any of:

  podman run .... openmpp/openmpp-build:centos-8 ./build-go   # Go oms web-service and dbcopy utility
  podman run .... openmpp/openmpp-build:centos-8 ./build-r    # openMpp R package
  podman run .... openmpp/openmpp-build:centos-8 ./build-ui   # openM++ UI
  
To create openmpp_centos_YYYYMMDD.tar.gz archive:

  podman run .... openmpp/openmpp-build:centos-8 ./build-tar-gz
  
  Environment variables to control "build-tar-gz": OM_MSG_USE, MODEL_DIRS

To open shell command prompt:

  podman run -it openmpp/openmpp-build:centos-8 bash
