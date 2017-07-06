# Nginx reverse proxy with ssl termination for rancher server
_maintained by codedevote_

## Overview
This Dockerfile gives you a secured nginx reverse proxy that terminates ssl and proxy passes to a rancher server.
This image is based on [marvambass/docker-nginx-ssl-secure](https://github.com/MarvAmBass/docker-nginx-ssl-secure) and adds a nginx configuration file for rancher server ([rancher/rancher](https://github.com/rancher/rancher)).

View in Docker Hub [codedevote/nginx-ssl-proxy-rancher](https://hub.docker.com/r/codedevote/nginx-ssl-proxy-rancher/)

View in GitHub [codedevote/docker-nginx-ssl-proxy-rancher](https://github.com/codedevote/docker-nginx-ssl-proxy-rancher)

## Environment variables and defaults

#### Inherited from base image
* __DH\_SIZE__
 * default: 2048 (which takes a long time to create), for demo or unsecure applications you can use smaller values like 512

#### Required by this image
* __RANCHER\_URL__
 * default: localhost
 
* __RANCHER\_PORT__
 * default: 8080

* __RANCHER\_CONTAINER_NAME__
 * default: rancher

 
## Running codedevote/nginx-ssl-proxy-rancher container
All the information on running the base image also applies to this container. 

#### Assumptions
* Since the nginx container needs to communicate with the rancher container, you need to make sure, there is a link between those two containers. You can either use the (deprecated) --link option to link the rancher container to the nginx container or you put both containers on a docker network (by creating one useing *docker network create*). There seems to be an issue (see #2) using the default docker bridge network, so make sure, you create a dedicated network and hook both containers to this network by adding the *--net* option to your *docker run* command.
* The rancher server can be reached from nginx container on the docker network at __http://$RANCHER\_CONTAINER_NAME:$RANCHER\_PORT__ (for information on how to setup a rancher server refer to [https://github.com/rancher/rancher](https://github.com/rancher/rancher)).
* You bind-mount a directory to __/etc/nginx/external__ with the following minimum contents:
 * SSL certificate (chained for intermediate CAs) in a file called __cert.pem__
 * Private key in a file called __key.pem__
 * You can also put a dh.pem file here (see base image docs). If not, one will be created on first start.

#### Run command
To run this image you can use the following command:

    docker run -d \
    -p 80:80 -p 443:443 \
    -e 'RANCHER_URL=rancher.example.org' \
    -e 'RANCHER_CONTAINER_NAME=rancher' \
    -e 'RANCHER_PORT=8080' \
    -v $EXT_DIR:/etc/nginx/external/ \
    codedevote/nginx-ssl-proxy-rancher


