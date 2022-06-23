#FROM python:3.6-slim
FROM  ubuntu:20.04

MAINTAINER shaikidurbasha469@gmail.com

RUN whoami
USER root
RUN whoami

# Let's start with some basic stuff.
RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables
    
# Install Docker from Docker Inc. repositories.
#RUN curl -sSL https://get.docker.com/ | sh

RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz


RUN curl -O https://bootstrap.pypa.io/3.6/get-pip.py
#RUN export DEBIAN_FRONTEND=noninteractive 

RUN apt-get install -y  --reinstall python3-pip
RUN pip3 install --upgrade pip


COPY . /python-test-calculator
WORKDIR /python-test-calculator


#COPY requirements.txt requirements.txt

RUN pip install --no-cache-dir -r requirements.txt
RUN ["pytest", "-v", "--junitxml=reports/result.xml"]

CMD tail -f /dev/null

#CMD ["/bin/bash"]