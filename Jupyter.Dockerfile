FROM ubuntu

COPY . /src
WORKDIR /src
#spark
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install build-essential -y
RUN apt-get update && apt-get install -y python3-pip python3-dev
RUN pip install delta-spark==1.1.0
RUN wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.2.0/hadoop-aws-3.2.0.jar -P $SPARK_HOME/jars/

RUN \
  apt-get update && \
  apt-get install -y openjdk-8-jdk && \
  rm -rf /var/lib/apt/lists/*

RUN pip install -r requirements.txt


# Set the AWS credentials
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}

# Install the Delta Lake library
RUN pip install delta-spark==1.1.0

# Install the AWS SDK for Python (Boto3)
RUN pip install boto3==1.18.59

CMD ["bash"]