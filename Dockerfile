# =============================================================================
# 
# MongoDB NodeJS Dockerfile
#
# Docker image running MongoDB and nodemon on /var/www/index.js on startup
# 
# Usage:
# docker build -t mongodb-nodejs .
# docker run -d -p 27017:27017 -p 28017:28017 -p 4000:4000 -v /Users/mountain/Sites/express-rest-api:/var/www --name mongodb-nodejs mongodb-nodejs
# 
# =============================================================================


# Pull base image.
FROM phusion/baseimage
LABEL version="0.0.1"


# ROOT SETUP ==================================================================

# Setup
ENV HOME "/root"
ENV NODE_PATH "/usr/lib/node_modules"
ENV PATH "$PATH:/usr/local/bin"

ADD startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh


# INSTALLATION ================================================================

# Install MongoDB.
RUN \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
  echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' > /etc/apt/sources.list.d/mongodb.list && \
  apt-get update && \
  apt-get install -y mongodb-org && \
  rm -rf /var/lib/apt/lists/* 

# NODEJS installation
RUN DEBIAN_FRONTEND="noninteractive" apt-get update && apt-get -y upgrade
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y mc curl sudo
RUN DEBIAN_FRONTEND="noninteractive" apt-get update --fix-missing
RUN DEBIAN_FRONTEND="noninteractive" curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y nodejs 
RUN DEBIAN_FRONTEND="noninteractive" npm install -g nodemon 


# SETUP =======================================================================

# Define mountable directories
VOLUME ["/data/db"]


# PORTS =======================================================================

# Expose ports
#   - 27017: MongoDB process
#   - 28017: MongoDB http
#   - 4000: NodeJS Express app port
EXPOSE 27017
EXPOSE 28017
EXPOSE 4000


# FINALIZATION ================================================================

# cleanup apt and lists
RUN apt-get clean
RUN apt-get autoclean

# Define default command
CMD ["/usr/local/bin/startup.sh"]
