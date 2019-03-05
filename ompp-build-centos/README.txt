=====================
To build openM++ run:

  docker run .... openmpp/openmpp-build:centos-7 ./build-all
  
  Examples:
  docker run -v $HOME/build:/home/ompp/build openmpp/openmpp-build:centos-7 ./build-all
  docker run -v $HOME/build:/home/ompp/build -e MODEL_DIRS=RiskPaths,IDMM      openmpp/openmpp-build:centos-7 ./build-all
  docker run -v $HOME/build:/home/ompp/build -e OM_BUILD_CONFIGS=RELEASE,DEBUG openmpp/openmpp-build:centos-7 ./build-all
  docker run -v $HOME/build:/home/ompp/build -e OM_MSG_USE=MPI                 openmpp/openmpp-build:centos-7 ./build-all

  Environment variables:
  OM_BUILD_CONFIGS=RELEASE,DEBUG (default: RELEASE,DEBUG for libraries and RELEASE for models)
  OM_MSG_USE=MPI                 (default: EMPTY)
  MODEL_DIRS=modelOne,NewCaseBased,NewTimeBased,NewCaseBased_bilingual,NewTimeBased_bilingual,IDMM,OzProj,OzProjGen,RiskPaths

To build openM++ libraries and omc compiler run:

  docker run .... openmpp/openmpp-build:centos-7 ./build-openm
  
  Environment variables to control "build-openm": OM_BUILD_CONFIGS, OM_MSG_USE

To build models run:

  docker run .... openmpp/openmpp-build:centos-7 ./build-modles
  
  Environment variables to control "build-modles": OM_BUILD_CONFIGS, OM_MSG_USE, MODEL_DIRS

To build openM++ tools run any of:

  docker run .... openmpp/openmpp-build:centos-7 ./build-go   # Go oms web-service and dbcopy utility
  docker run .... openmpp/openmpp-build:centos-7 ./build-r    # openMpp R package
  docker run .... openmpp/openmpp-build:centos-7 ./build-ui   # openM++ UI (alpha)
  
To create openmpp_centos_YYYYMMDD.tar.gz archive:

  docker run .... openmpp/openmpp-build:centos-7 ./build-tar-gz
  
  Environment variables to control "build-tar-gz": OM_MSG_USE, MODEL_DIRS

To open shell command prompt:

  docker run .... -it openmpp/openmpp-build:centos-7 bash
