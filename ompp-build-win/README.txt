## Using image

To build openM++ do:

  docker run .... openmpp/openmpp-build:windows-20H2 build-all

  Examples:
  docker run --isolation process -v C:\my\build:C:\build openmpp/openmpp-build:windows-20H2 build-all
  docker run --isolation process -v C:\my\build:C:\build -e OM_BUILD_PLATFORMS=x64 openmpp/openmpp-build:windows-20H2 build-all
  docker run --isolation process -v C:\my\build:C:\build -e MODEL_DIRS=RiskPaths   openmpp/openmpp-build:windows-20H2 build-all

  Environment variables:
  set OM_BUILD_CONFIGS=Release,Debug (default: Release)
  set OM_BUILD_PLATFORMS=Win32,x64   (default: Win32)
  set OM_MSG_USE=MPI                 (default: EMPTY)
  set MODEL_DIRS=modelOne,NewCaseBased,NewTimeBased,NewCaseBased_bilingual,NewTimeBased_bilingual,IDMM,OzProj,OzProjGen,RiskPaths

To build openM++ libraries and omc compiler do:

  docker run .... openmpp/openmpp-build:windows-20H2 build-openm
  
  Environment variables to control "build-openm": OM_BUILD_CONFIGS, OM_BUILD_PLATFORMS, OM_MSG_USE

To build models do:

  docker run .... openmpp/openmpp-build:windows-20H2 build-models
  
  Environment variables to control "build-models": OM_BUILD_CONFIGS, OM_BUILD_PLATFORMS, OM_MSG_USE, MODEL_DIRS

To build openM++ tools do any of:

  docker run .... openmpp/openmpp-build:windows-20H2 build-go   # Go oms web-service and dbcopy utility
  docker run .... openmpp/openmpp-build:windows-20H2 build-r    # openMpp R package
  docker run .... openmpp/openmpp-build:windows-20H2 build-perl # Perl utilities
  docker run .... openmpp/openmpp-build:windows-20H2 build-ui   # openM++ UI

To create openmpp_win_YYYYMMDD.zip archive:

  docker run .... openmpp/openmpp-build:windows-20H2 build-zip
  
  Environment variables to control "build-zip": OM_MSG_USE, MODEL_DIRS

To open cmd command prompt or Perl command prompt:

  docker run .... -it openmpp/openmpp-build:windows-20H2 cmd
  docker run .... -it openmpp/openmpp-build:windows-20H2 C:\perl32\portableshell
