FROM ubuntu:20.04

RUN if ! [ "$(arch)" = "aarch64" ] ; then exit 1; fi

#Install core OS packages
RUN apt-get -y update && \
    apt-get -y install software-properties-common && \
    add-apt-repository ppa:ubuntu-toolchain-r/test && \
    apt-get -y install \
      autoconf \
      bc \
      build-essential \
      cmake \
      curl \
      gettext-base \
      git \
      iputils-ping \
      libbz2-dev \
      libc++-dev \
      libcgal-dev \
      libffi-dev \
      libfreetype6-dev \
      libhdf5-dev \
      libjpeg-dev \
      liblzma-dev \
      libncurses5-dev \
      libncursesw5-dev \
      libpng-dev \
      libreadline-dev \
      libssl-dev \
      libsqlite3-dev \
      libxml2-dev \
      libxslt-dev \
      locales \
      moreutils \
      openssl \
      python \
      python-openssl \
      python3 \
      python3-pip \
      rsync \
      scons \
      ssh \
      sudo \
      time \
      unzip \
      vim \
      wget \
      xz-utils \
      zip \
      zlib1g-dev

# Install TFlite
RUN python3 -m pip install pillow
RUN python3 -m pip install tflite-runtime

# DOCKER_USER for the Docker user
ENV DOCKER_USER=ubuntu

# Setup default user
RUN useradd --create-home -s /bin/bash -m $DOCKER_USER && \
  echo "$DOCKER_USER:Portland" | chpasswd && adduser $DOCKER_USER sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Copy example how to run it
COPY --chown=$DOCKER_USER:$DOCKER_USER label_image_python /home/$DOCKER_USER/.

# Set user and env
WORKDIR /home/$DOCKER_USER
USER $DOCKER_USER

CMD ["python3", "label_image.py"]
