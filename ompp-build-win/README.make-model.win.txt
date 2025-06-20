## Using openmpp-build image to build and run models

To build and (optionally) openM++ model do:

docker run .... openmpp/openmpp-build:windows-ltsc2025 make-model

Windows Docker examples:

docker run ^
  -v C:\my\build:C:\build ^
  -e OM_ROOT=ompp ^
  -e MODEL_DIR=ompp\models\RiskPaths ^
  openmpp/openmpp-build:windows-ltsc2025 ^
  make-model

docker run ^
  -v C:\my\build:C:\build ^
  -e OM_ROOT=openmpp_win_20250601 ^
  -e MODEL_NAME=RiskPaths ^
  -e MODEL_INI=my\test.ini ^
  openmpp/openmpp-build:windows-ltsc2025 ^
  make-model

docker run ^
  -v C:\my\build:C:\build ^
  -e OM_ROOT=ompp ^
  -e MODEL_NAME=RiskPaths ^
  -e MODEL_DIR=my\RiskPaths ^
  -e MODEL_GIT_URL=https://gitlab.com/my/RiskPaths.git
  -e MODEL_GIT_TAG=v1.2.3
  openmpp/openmpp-build:windows-ltsc2025 ^
  make-model

Windows examples, no Docker, use Visual Studio Command Prompt to run it:

cd \tmp
set OM_ROOT=openmpp_win_20250601
set MODEL_DIR=my\RiskPaths
\ompp-docker\ompp-build-win\make-model.bat

cd \tmp
set OM_ROOT=C:\my\openmpp
set MODEL_NAME=RiskPaths
set MODEL_DIR=my\RiskPaths
set MODEL_INI=my\test.ini
set MODEL_GIT_URL=https://gitlab.com/my/RiskPaths.git
set MODEL_GIT_TAG=v1.2.3
C:\my\openmpp\ompp-docker\ompp-build-win\make-model.bat

Environment variables:

OM_ROOT                   default: ..\..
OM_BUILD_CONFIGS=Debug    default: Release
OM_BUILD_PLATFORMS=Win32  default: x64
OM_MSG_USE=MPI            default: EMPTY
MODEL_NAME          if not empty then model name
MODEL_DIR           if not empty then model source code directory
MODEL_GIT_URL       if not empty then git URL of model source code
MODEL_GIT_TAG       if not empty then git tag
MODEL_INI           if not empty then run model after build with this model ini file

One of: MODEL_NAME or MODEL_DIR must be defined

if MODEL_NAME not empty and MODEL_DIR empty then MODEL_DIR  = OM_ROOT\models\MODEL_NAME
if MODEL_NAME empty and MODEL_DIR not empty then MODEL_NAME = last element of MODEL_DIR

if MODEL_DIR not exists and MODEL_GIT_URL specified then do git clone model source code
