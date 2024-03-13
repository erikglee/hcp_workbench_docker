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

# Install dependencies required for adding a PPA and compiling Python packages
RUN apt-get update && apt-get install -y \
    software-properties-common \
    build-essential \
    wget \
    python3.12-venv \
    python3.12-dev \
    python3-distutils

# Create a virtual environment
# Replace `/usr/src/app/venv` with your preferred location for the virtual environment
RUN python3.12 -m venv /usr/src/app/venv

# Activate the virtual environment
ENV PATH="/usr/src/app/venv/bin:$PATH"

# Now using the virtual environment, upgrade pip
RUN pip install --upgrade pip

# Set the working directory in the container
WORKDIR /usr/src/app

# Install any needed packages specified in requirements.txt
RUN python -m pip install nibabel==5.2.1
RUN python -m pip install numpy==1.24.3
RUN python -m pip install matplotlib==3.8.3
RUN python -m pip install pandas==2.1.4
RUN python -m pip install scipy==1.11.4
RUN python -m pip install scikit-learn==1.3.2
