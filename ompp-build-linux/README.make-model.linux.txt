## Using openmpp-build image to build and run models

To build and (optionally) openM++ model do:

docker run .... openmpp/openmpp-build:debian ./make-model

Debian Linux Docker examples:

docker run \
  -v $HOME/stable-debian/build:/home/build \
  -e OMPP_USER=build -e OMPP_GROUP=build -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
  -e OM_ROOT=ompp \
  -e MODEL_DIR=ompp/models/RiskPaths \
  openmpp/openmpp-build:debian \
  ./make-model

docker run \
  -v $HOME/stable-debian/build:/home/build \
  -e OMPP_USER=build -e OMPP_GROUP=build -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
  -e OM_ROOT=openmpp_win_20250601 \
  -e MODEL_NAME=RiskPaths \
  -e MODEL_INI=my\test.ini \
  openmpp/openmpp-build:debian \
  ./make-model

docker run \
  -v $HOME/stable-debian/build:/home/build \
  -e OMPP_USER=build -e OMPP_GROUP=build -e OMPP_UID=$UID -e OMPP_GID=`id -g` \
  -e OM_ROOT=ompp \
  -e MODEL_NAME=RiskPaths \
  -e MODEL_DIR=my/RiskPaths \
  -e MODEL_GIT_URL=https://gitlab.com/my/RiskPaths.git
  -e MODEL_GIT_TAG=v1.2.3
  ./make-model

Debian Linux examples, no Docker, you should have c++ installed to run it:

export OM_ROOT=~/openmpp_debian_20250601
export MODEL_DIR=my/RiskPaths
~/ompp-docker/ompp-build-linux/make-model

export OM_ROOT=~/openmpp_debian_20250601
export OM_ROOT=ompp
export MODEL_NAME=RiskPaths
export MODEL_DIR=my/RiskPaths
export MODEL_INI=my\test.ini
export MODEL_GIT_URL=https://gitlab.com/my/RiskPaths.git
export MODEL_GIT_TAG=v1.2.3
~/ompp-docker/ompp-build-linux/make-model

Environment variables:

OM_ROOT                   default: ../..
OM_BUILD_CONFIGS=DEBUG    default: RELEASE
OM_MSG_USE=MPI            default: EMPTY
MODEL_NAME          if not empty then model name
MODEL_DIR           if not empty then model source code directory
MODEL_GIT_URL       if not empty then git URL of model source code
MODEL_GIT_TAG       if not empty then git tag
MODEL_INI           if not empty then run model after build with this model ini file

One of: MODEL_NAME or MODEL_DIR must be defined

if MODEL_NAME not empty and MODEL_DIR empty then MODEL_DIR  = OM_ROOT/models/MODEL_NAME
if MODEL_NAME empty and MODEL_DIR not empty then MODEL_NAME = last element of MODEL_DIR

if MODEL_DIR not exists and MODEL_GIT_URL specified then do git clone model source code
