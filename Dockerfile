#
# AMP Dockerfile
#
# https://github.com/othrayte/docker-cc-amp
#

# Pull base image.
FROM debian

# Install dependencies
RUN apt-get update && apt-get install -y \
  lib32gcc1 \
  coreutils \
  screen \
  socat \
  unzip \
  git \
  wget \
  openjdk-7-jre \
&& rm -rf /var/lib/apt/lists/*

RUN \
  groupadd -r AMP && \
  useradd -r -g AMP -d /home/AMP -m AMP && \
  mkdir ~/AMP && \
  cd ~/AMP && \
  wget http://cubecoders.com/Downloads/ampinstmgr.zip && \
  unzip ampinstmgr.zip && \
  rm -i ampinstmgr.zip

# Define working directory.
WORKDIR /home/AMP/AMP

COPY start_ads.sh /home/AMP/AMP/

RUN \
  chown AMP:AMP ./start_ads.sh && \
  chmod +x ./start_ads.sh

USER AMP

# Define default command.
CMD ["./start_ads.sh"]

# Expose ports.
EXPOSE 8080
