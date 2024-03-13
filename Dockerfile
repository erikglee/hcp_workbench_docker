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
                    libglu1-mesa \
                    libxi-dev \
                    libxmu-dev \
                    libglu1-mesa-dev \
                    pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/

RUN mkdir /wb_code
RUN wget https://s3.msi.umn.edu/leex6144-public/workbench-linux64-v1.5.0.zip -O /wb_code/workbench-linux64-v1.5.0.zip \
    && cd /wb_code && unzip -q ./workbench-linux64-v1.5.0.zip \
    && rm /wb_code/workbench-linux64-v1.5.0.zip

ENV PATH="${PATH}:/wb_code/workbench/bin_linux64"

# Install Python and necessary packages
RUN apt-get update && apt-get install -y python3.12 python3.12-venv python3.12-dev python3-distutils build-essential libatlas-base-dev gfortran

# Create a virtual environment
RUN python3.12 -m venv /usr/src/app/venv

# Activate the virtual environment
ENV PATH="/usr/src/app/venv/bin:$PATH"

# Upgrade pip, setuptools, and wheel
RUN pip install --upgrade pip setuptools wheel

# Set the working directory in the container
WORKDIR /usr/src/app

# Install any needed packages specified in requirements.txt
RUN python -m pip install nibabel==5.2.1
#RUN python -m pip install numpy==1.24.3
RUN python -m pip install matplotlib==3.8.3
RUN python -m pip install pandas==2.1.4
RUN python -m pip install scipy==1.11.4
RUN python -m pip install scikit-learn==1.3.2
