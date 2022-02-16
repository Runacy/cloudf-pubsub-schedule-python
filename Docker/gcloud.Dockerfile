FROM google/cloud-sdk:latest

RUN apt install -y && apt update -y
RUN apt install -y git curl sudo

WORKDIR /app