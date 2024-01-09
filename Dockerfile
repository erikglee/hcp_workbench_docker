FROM ubuntu:24.04

# Prepare environment
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    apt-utils \
                    autoconf \
                    build-essential \
                    bzip2 \
                    ca-certificates \
                    curl \
                    gcc \
                    git \
                    gnupg \
                    libtool \
                    lsb-release \
                    pkg-config \
                    unzip \
                    wget \
                    xvfb \
                    default-jre \
                    zlib1g \
                    pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/

RUN mkdir /wb_code
RUN wget https://s3.msi.umn.edu/leex6144-public/workbench-linux64-v1.5.0.zip -O /wb_code/workbench-linux64-v1.5.0.zip \
    && cd /wb_code && unzip -q ./workbench-linux64-v1.5.0.zip \
    && rm /wb_code/workbench-linux64-v1.5.0.zip

ENV PATH="${PATH}:/wb_code/workbench/bin_linux64"
