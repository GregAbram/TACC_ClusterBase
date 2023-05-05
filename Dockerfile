FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt-get update \
  && apt-get install -y -qq --no-install-recommends \
    libglvnd0 \
    libgl1 \
    libglx0 \
    libegl1 \
    libxext6 \
    libx11-6 \
    glmark2 \
    mesa-utils \
    xterm \
    telnet \
    vim \
  && rm -rf /var/lib/apt/lists/*

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute

RUN apt-get --yes -qq update \
 && apt-get --yes -qq upgrade \
 && apt-get --yes -qq install \
                      bzip2 \
                      cpio \
                      curl \
                      g++-8 \
                      gcc-8 \
                      gfortran \
                      git \
                      gosu \
                      libblas-dev \
                      liblapack-dev \
                      python3-dev \
                      python3-pip \
                      virtualenv \
                      wget \
                      zlib1g-dev \
                      vim       \
                      tzdata \
                      libpulse-dev \
                      xterm \
                      freeglut3-dev \
                      libnss3 \
                      libxcursor1  \
                      libxcursor-dev  \
                      libxi-dev  \
                      libxkbcommon0 \
                      libxrandr-dev \
                      libxinerama-dev \
                      libasound2 \
                      libgssapi-krb5-2 \
                      libqt5gui5 \
                      htop \
                      libglew-dev \
                      libncurses5-dev \
                      gdb

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 8 && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 8

RUN apt-get update && apt-get -y install openssl libssl-dev

RUN apt-get --yes -qq clean \
 && rm -rf /var/lib/apt/lists/*

RUN wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.1.tar.gz \
  && tar xzf openmpi-4.1.1.tar.gz \
  && cd openmpi-4.1.1 \
  && ./configure \
  && make -j 5 install \ 
  && cd ..

RUN rm -rf openmpi-4.1.1.tar.gz openmpi-4.1.1

RUN wget https://github.com/Kitware/CMake/releases/download/v3.24.3/cmake-3.24.3.tar.gz \
  && tar xzf cmake-3.24.3.tar.gz \
  && cd cmake-3.24.3 \
  && ./bootstrap \
  && make -j 6 \
  && make install \
  && cd ..

RUN rm -rf cmake-3.24.3.tar.gz cmake-3.24.3

RUN wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.1.tar.gz \
  && tar xzf openmpi-4.1.1.tar.gz \
  && cd openmpi-4.1.1 \
  && ./configure \
  && make -j 5 install \ 
  && cd ..

RUN rm -rf openmpi-4.1.1.tar.gz openmpi-4.1.1

RUN wget https://www.vtk.org/files/release/9.2/VTK-9.2.6.tar.gz \
  && tar xzf VTK-9.2.6.tar.gz \
  && cd VTK-9.2.6 \
  && mkdir build \
  && cd build \
  && cmake .. \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DVTK_GROUP_ENABLE_Qt=NO \
    -DVTK_WRAP_PYTHON=ON \
  && make -j 5 install

RUN rm -rf VTK-9.2.6  VTK-9.2.6.tar.gz cmake-3.24.3.tar.gz openmpi-4.1.1 openmpi-4.1.1.tar.gz

CMD [ "/bin/bash" ]

