# Base Image
ARG CUDA_VER=${CUDA_VER:-11.4.3}
ARG CUDNN_VER=${CUDNN_VER:-8}
ARG DISTRO=${DISTRO:-ubuntu20.04}
FROM nvidia/cuda:${CUDA_VER}-cudnn${CUDNN_VER}-devel-${DISTRO}

# System
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Change apt repository server to japanese server
RUN sed -i -e 's%http://.*.ubuntu.com%http://ftp.jaist.ac.jp/pub/Linux%g' /etc/apt/sources.list
RUN apt update && apt upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt install -y software-properties-common
RUN apt update && add-apt-repository ppa:deadsnakes/ppa

RUN apt install -y \
        build-essential \
        vim \
        htop \
        git \
        wget \
        unzip \
        libcurl4-openssl-dev \
        zlib1g-dev \
        gosu \
        libgl1-mesa-glx \
        curl \
        net-tools \
        python3.10 \
        python3.10-dev \
        pip \
        sudo

# User change utility
RUN gosu nobody true

RUN pip install torch==1.11.0+cu113 torchvision==0.12.0+cu113 --extra-index-url https://download.pytorch.org/whl/cu113

# user setting
ARG RUN_USER
ARG RUN_GROUP
ARG RUN_UID
ARG RUN_GID
ENV RUN_USER=${RUN_USER:-developer}
ENV RUN_GROUP=${RUN_GROUP:-developer}
ENV RUN_UID=${RUN_UID:-1000}
ENV RUN_GID=${RUN_GID:-1000}

RUN umask 0002 && \
    groupadd -g ${RUN_GID} ${RUN_GROUP} && \
    useradd --shell /bin/bash -u ${RUN_UID} -g ${RUN_GID} -o -c "" -m ${RUN_USER} && \
    chmod -R 2775 /opt && \
    chown -R ${RUN_USER}:${RUN_GROUP} /opt

# add sudouser without passwd
RUN echo "${RUN_USER}    ALL=(ALL)       NOPASSWD:ALL" >> /etc/sudoers

EXPOSE 8080
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

#USER ${RUN_USER}:${RUN_GROUP}
WORKDIR /work/shared

