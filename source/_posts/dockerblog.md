---
title: dockerblog
date: 2017-07-24 22:26:39
tags:
  - docker
  - docker-compose
  - technical
categories: Technical
---
# Deploy blog in Docker
<!-- more -->

After you build your own blog site, you may Deploy it in your VPS and use *npm install* to install lot of things . But with docker, you can deploy your website anywhere!

## Use Docker

### Install Docker in your server
Install Docker in your server, [``How to``](https://store.docker.com/search?offering=community&type=edition)? Choose your os and install it!

Use
```bash
$ docker ps
```
to see if docker is installed properly

### Use Dockerfile to build image
First of all, choose a properly image as your base image.
{% asset_img alpinenode.png %}
we choose [``node:alpine``](https://hub.docker.com/r/library/node/tags/) because it's small and support npm.


Dockerfile:
```Dockerfile
FROM node:8.2.1-alpine
ENV KCP_VER 20170525
RUN \
    apk add git --update \
    &&  npm config set unsafe-perm=true \
    &&  npm install -g hexo-cli \
    &&  git clone https://github.com/moclaF/myblog.git \
    &&  cd myblog && npm install
WORKDIR /myblog
EXPOSE 4000
CMD hexo server
```

> when we use ``npm install -g`` we may get ``EACESS`` error, use ``npm config set unsafe-perm=true`` to resolve it

then use:
```bash
$ docker build -t [image]:[tag] .
```
to build an image

### Use Dockerhub to autobuild your images
You can connect your Dockerhub to your github, and select a branch in repo to [``autobuild``](https://hub.docker.com/add/automated-build/library/) images in Dockerhub.
Here are [``my Repository``](https://hub.docker.com/u/moclaf/).

### Run your images
For example:
```bash
$ docker pull moclaf/myblog:latest
$ docker run -p [ports]:4000 -d moclaf/myblog:latest
```
replace ports to a ports you want.
then use:
```bash
$ docker ps
$ docker logs [container id] -f
```
to see logs of your Hexo Server

## Use docker-compose

### install docker-compose
You can use:
```bash
$ curl -L https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
```
or [``another ways``](https://docs.docker.com/compose/install/).

### docker-compose file
[``compose preference``](https://docs.docker.com/compose/compose-file/)
Example: xxx-compose.yml
```yml
version: '2'
services:
  myblog:
    image: moclaf/myblog:latest
    ports:
        - "80:4000"
    volumes:
        - ./source:/myblog/source
    restart: always
```

then use:
```bash
$ docker-compose -f xxx-compose.yml pull
$ docker-compose -f xxx-compose.yml up -d
```
Done!

my blog repo address: [``myblog``](https://github.com/moclaF/myblog)


Author  Yasin Chan
