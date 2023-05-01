#!/bin/bash

. environment.sh
DOCKERFILE=${1:-Dockerfile}

docker build \
  --build-arg CUDA_VER=${CUDA_VER} \
  --build-arg CUDNN_VER=${CUDNN_VER} \
  --build-arg PYTHON_VER=${PYTHON_VER} \
  --build-arg HTTP_PROXY=${HTTP_PROXY} \
  --build-arg HTTPS_PROXY=${HTTPS_PROXY} \
  --build-arg NO_PROXY=${NO_PROXY} \
  --build-arg http_proxy=${http_proxy} \
  --build-arg https_proxy=${https_proxy} \
  --build-arg no_proxy=${no_proxy} \
  --build-arg RUN_USER=$RUN_USER \
  --build-arg RUN_UID=$RUN_UID \
  --build-arg RUN_GROUP=$RUN_GROUP \
  --build-arg RUN_GID=$RUN_GID \
  -t ${BASENAME}:${TAG} \
  -f ${DOCKERFILE} \
  .
