## Using image

To build openM++ do:

  docker run .... openmpp/openmpp-build:windows-20H2 build-all

  Examples:
  docker run -v C:\my\build:C:\build openmpp/openmpp-build:windows-20H2 build-all
  docker run -v C:\my\build:C:\build -e OM_BUILD_PLATFORMS=x64 openmpp/openmpp-build:windows-20H2 build-all
  docker run -v C:\my\build:C:\build -e MODEL_DIRS=RiskPaths   openmpp/openmpp-build:windows-20H2 build-all

  Environment variables:
  set OMPP_BUILD_TAG=v1.2.3          (default: build from latest git)
  set OM_BUILD_CONFIGS=Release,Debug (default: Release)
  set OM_BUILD_PLATFORMS=Win32,x64   (default: Win32)
  set OM_MSG_USE=MPI                 (default: EMPTY)
  set OM_DATE_STAMP=20220817         (default: current date as YYYYMMDD)
  set MODEL_DIRS=modelOne,NewCaseBased,NewTimeBased,NewCaseBased_bilingual,IDMM,RiskPaths,OzProjGenX,OzProjX,SM1

  set OMPP_GIT_URL=https://github.com/openmpp (default)

Additional environment variable for build-open and build-model:
  OMPP_CPP_BUILD_TAG=test_branch     (default: build from latest git)

If both OMPP_BUILD_TAG and OMPP_CPP_BUILD_TAG specified then OMPP_CPP_BUILD_TAG take precedence

To build openM++ libraries and omc compiler do:

  docker run .... openmpp/openmpp-build:windows-20H2 build-openm
  
  Environment variables to control "build-openm": OM_BUILD_CONFIGS, OM_BUILD_PLATFORMS, OM_MSG_USE, OMPP_BUILD_TAG, OMPP_CPP_BUILD_TAG

To build models do:

  docker run .... openmpp/openmpp-build:windows-20H2 build-models
  
  Environment variables to control "build-models": OM_BUILD_CONFIGS, OM_BUILD_PLATFORMS, OM_MSG_USE, MODEL_DIRS, OMPP_BUILD_TAG, OMPP_CPP_BUILD_TAG

To build openM++ tools do any of:

  docker run .... openmpp/openmpp-build:windows-20H2 build-go   # Go oms web-service and dbcopy utility
  docker run .... openmpp/openmpp-build:windows-20H2 build-r    # openMpp R package
  docker run .... openmpp/openmpp-build:windows-20H2 build-perl # Perl utilities
  docker run .... openmpp/openmpp-build:windows-20H2 build-ui   # openM++ UI

To create openmpp_win_YYYYMMDD.zip archive:

  docker run .... openmpp/openmpp-build:windows-20H2 build-zip
  
  Environment variables to control "build-zip": OM_MSG_USE, MODEL_DIRS, OM_DATE_STAMP

To open cmd command prompt or Perl command prompt:

  docker run .... -it openmpp/openmpp-build:windows-20H2 cmd
  docker run .... -it openmpp/openmpp-build:windows-20H2 C:\perl32\portableshell
