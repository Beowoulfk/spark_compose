FROM ubuntu

COPY . /src
WORKDIR /src
#spark
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install build-essential -y
RUN apt-get update && apt-get install -y python3-pip python3-dev

RUN \
  apt-get update && \
  apt-get install -y openjdk-8-jdk && \
  rm -rf /var/lib/apt/lists/*

RUN pip install -r requirements.txt


CMD ["bash"]