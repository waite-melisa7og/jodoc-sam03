FROM ubuntu:24.04

RUN apt-get update \
 && apt-get install software-properties-common -y \
 && add-apt-repository ppa:ubuntu-toolchain-r/test -y \
 && add-apt-repository ppa:ondrej/php -y \
 && apt-get update \
 && apt-get upgrade -y
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Moscow
RUN apt-get install -y tzdata && \
    apt-get install -y \
    curl \
    zip \
    screen \
    sudo \
    wget \
    htop \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_22.x | bash -
RUN apt-get install nodejs -y

# Create app directory
WORKDIR /app

COPY . .

RUN npm install

RUN chmod u+x build-setup && ./build-setup

EXPOSE 8080
CMD [ "node", "server.js" ]
