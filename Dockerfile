# Frontend Dockerfile
# Based on https://github.com/dockerfile/ubuntu

# Pull base image.
FROM ubuntu:12.04

# Avoid any apt dialog errors
ENV DEBIAN_FRONTEND noninteractive

# Set locale
RUN dpkg-reconfigure locales && \
    locale-gen en_GB.UTF-8 && \
    /usr/sbin/update-locale LANG=en_GB.UTF-8

ENV LC_ALL en_GB.UTF-8

RUN \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv C7917B12 && \
  echo 'deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu precise main' | tee /etc/apt/sources.list.d/nodejs.list && \
  apt-get update && \
  apt-get install -y -o "Acquire::http::Timeout=900" --no-install-recommends python-software-properties python g++ make nodejs openjdk-7-jdk ruby1.9.1-full git libpng-dev nodejs &&\
  npm -g install grunt-cli && \
  gem install bundler && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install (https://github.com/guardian/frontend/blob/master/provision.sh)
RUN mkdir /etc/gu && echo -e 'STAGE=DEV\nINT_SERVICE_DOMAIN=gudev.gnl\nEXT_SERVICE_DOMAIN=' > /etc/gu/install_var

# Create user
#RUN useradd -m -d /home/nuxeo -s /bin/bash -p nuxeo nuxeo

# Define working directory.
WORKDIR /tmp

# Define default command.
CMD ["bash"]

# Expose ports.
EXPOSE 9000
EXPOSE 18080
