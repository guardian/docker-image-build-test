#
# Ubuntu Dockerfile
#
# Based on https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:12.04

# Install (https://github.com/guardian/frontend/blob/master/provision.sh)
RUN \
  mkdir /etc/gu && \
  echo -e 'STAGE=DEV\nINT_SERVICE_DOMAIN=gudev.gnl\nEXT_SERVICE_DOMAIN=' > /etc/gu/install_var && \
  apt-get install -y python-software-properties python g++ make && \
  add-apt-repository -y ppa:chris-lea/node.js && \
  apt-get update && \
  apt-get install -y nodejs && \
  npm -g install grunt-cli && \
  apt-get install -y  -o "Acquire::http::Timeout=900" openjdk-7-jdk && \
  apt-get install -y ruby1.9.1-full git libpng-dev && \
  gem install bundler

# Add files.
#ADD root/.bashrc /root/.bashrc
#ADD root/.gitconfig /root/.gitconfig
#ADD root/scripts /root/scripts

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]

# Expose ports.
EXPOSE 9000
EXPOSE 18080
