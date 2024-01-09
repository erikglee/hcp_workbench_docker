FROM ubuntu:24.04


RUN mkdir /wb_code
RUN wget https://s3.msi.umn.edu/leex6144-public/workbench-linux64-v1.5.0.zip -O /wb_code/workbench-linux64-v1.5.0.zip \
    && cd /wb_code && unzip -q ./workbench-linux64-v1.5.0.zip \
    && rm /wb_code/workbench-linux64-v1.5.0.zip

ENV PATH="${PATH}:/wb_code/workbench/bin_linux64"
