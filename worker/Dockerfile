# Usa Ubuntu come sistema operativo di base
FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    pdal \
    git \
    cmake \
    build-essential \
    libtbb-dev \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN git clone https://github.com/potree/PotreeConverter.git \
    && cd PotreeConverter \
    && mkdir build \
    && cd build \
    && cmake ../ \
    && make \
    && cp PotreeConverter /usr/local/bin/

COPY --from=minio/mc:latest /usr/bin/mc /usr/local/bin/mc

WORKDIR /data
CMD ["/bin/bash"]