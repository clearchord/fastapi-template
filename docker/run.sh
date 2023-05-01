#!/bin/bash

# Run build, and get parameters
. ./environment.sh

# Runtime parameters
GPU=${GPU:-all}
NVRUNTIME="--gpus all"

WORKDIR=$(pwd)/../../

CONTAINER_ALIAS=$(whoami)_${PROJECT}
_PORT=${1:-8080}

mkdir -p ${WORKDIR}
docker run ${NVRUNTIME} -it --rm \
  --name ${CONTAINER_ALIAS}_GPU${GPU} \
  -v ${WORKDIR}:/work/shared \
  -v /etc/localtime:/etc/localtime:ro \
  -v $HOME/.Xauthority:/home/$RUN_USER/.Xauthority:rw \
  --env NVIDIA_DRIVER_CAPABILITIES=video,compute,utility \
  --env NVIDIA_VISIBLE_DEVICES=$GPU \
  --env HTTP_PROXY=$HTTP_PROXY \
  --env HTTPS_PROXY=$HTTPS_PROXY \
  --env NO_PROXY=$NO_PROXY \
  --env http_proxy=$http_proxy \
  --env https_proxy=$https_proxy \
  --env no_proxy=$no_proxy \
  --env RUN_USER=$RUN_USER \
  --env RUN_UID=$RUN_UID \
  --env RUN_GROUP=$RUN_GROUP \
  --env RUN_GID=$RUN_GID \
  --env DISPLAY=$DISPLAY \
  --net host \
  ${BASENAME}:${TAG} /bin/bash 
