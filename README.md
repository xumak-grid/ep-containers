# ep-containers

This repository contains elasticPath Docker image definitions for Grid, all images are base on alpine:3.7 and Java Oracle jre8

The initial definitions were taken from: https://code.elasticpath.com/ep-cloudops/docker

## Prerequisites

- Access to the local Xumak registry to pull the base images

*Go to Deamon and add `your.registry` in Insecure registries*
- Setup memory usage by Docker

*Go to Advanced and add **8GiB** in Memory*
- The EP deployment package (`ext-deployment-package-VERSION.zip`) Copy it into a local directory

*~/bin/EP/ext-deployment-package-710.0.0-SNAPSHOT.zip*
- From [docker](https://code.elasticpath.com/ep-cloudops/docker) repository copy `external-solrHome` directory into a directory in you local machine. That directory contains all of the necessary **Solr** configuration files to EP `search` container

```
cp -r EpImageBuilder/config/external-solrHome ~/ep/external-solrHome
```

## Base images

The EP images are based on the following images: 

```
your.registry/xumak/base:alpine3.7
your.registry/xumak/oracle-8-jre:8u172
your.registry/grid/tomcat:7.0.85-jre8
your.registry/ep/mysql-ep-data:1.0.0
```
**Notice:** mysql image was built using EP scripts

## Building images

```
make build
```

or change package location

```
make build PKG=~/new/location/ext-deployment-package-710.0.0-SNAPSHOT.zip
```

If you want to build a single app, run `make <step>` inside each directory, for example to build only cortex

```
cd cortex
make binaries build
```

## Starting up apps

Start all apps

```
docker-compose up -d
docker-compose ps
```

In development you may want to start only some of the apps

```
docker-compose up -d mysql activemq cortex search
```

## Apps info

Your apps are running in `localhost` for example http://localhost:8080/studio

```
- Name       - Ports      - Credentials   - Routers
cortex      | 8080 1081  |               | /studio /cortex/status /cortex/healthcheck
cm          | 8086       | admin:111111  | /cm/status
search      | 8082       |               | /search/status
batch       | 8084       |               | /batch/status
integration | 8083       |               | /integration/status
activemq    | 8161 61616 | admin:admin   | /admin
mysql       | 3306       |               |
```

Tomcat default credentials `(ep-user:password)`

## Apps Logs

All apps logs are printed to standard output

```
docker-compose logs -f
docker-compose logs -f <app-name>
```

## Cleaning workspace

```
docker-compose stop
docker-compose rm -f
make clean
```

## Issues

1. The `search` container shows memory usage over 2G. `docker stats` shows that container is using ~2.44GiB. Logs of the container show a lot of work and it logs are never ending. The container sometimes is stopped.

 ```
search         | INFO  schedulerFactory_Worker-9 2018-04-18 16:30:30,341 com.elasticpath.search.index.solr.service.impl.AbstractIndexServiceImpl.buildIndexJobRunner(AbstractIndexServiceImpl.java:147) - Index build job started for type:customer at Wed Apr 18 16:30:30 GMT 2018
search         | INFO  schedulerFactory_Worker-4 2018-04-18 16:30:30,341 com.elasticpath.search.index.solr.service.impl.AbstractIndexServiceImpl.buildIndexJobRunner(AbstractIndexServiceImpl.java:147) - Index build job started for type:category at Wed Apr 18 16:30:30 GMT 2018
search         | INFO  schedulerFactory_Worker-5 2018-04-18 16:30:30,342 com.elasticpath.search.index.solr.service.impl.AbstractIndexServiceImpl.buildIndexJobRunner(AbstractIndexServiceImpl.java:147) - Index build job started for type:shippingservicelevel at Wed Apr 18 16:30:30 GMT 2018
 ```

## Admin tasks

### Push to Grid registry

Build and push to AWS Grid Registry. We host the images in AWS ECS repositories.

- Configure AWS CLI with Grid credentials (use **us-east-1** region)

`aws configure --profile grid`

- Build images with custom registry and tag

`make build REGISTRY_NAME=your.image IMAGE_TAG=1.0.0`

- Docker login

`$(aws ecr get-login --no-include-email --profile grid)`

- Push images

`make push REGISTRY_NAME=your.image IMAGE_TAG=1.0.0`

- Clean images

`make clean REGISTRY_NAME=your.image IMAGE_TAG=1.0.0`

### deploy to k8s cluster

```
kubectl create ns ep-demo
kubectl -n ep-demo create \
    -f mysql/k8s/mysql-secret.yaml \
    -f mysql/k8s/mysql-deployment.yaml \
    -f activemq/k8s/deployment.yaml \
    -f search/k8s/deployment.yaml \
    -f batch/k8s/deployment.yaml \
    -f cm/k8s/deployment.yaml \
    -f cortex/k8s/deployment.yaml \
    -f integration/k8s/deployment.yaml
```

### Create initial EP Nexus

- Go to [Nexus README](nexus/README.md)

Copyright © 2016 Tikal Technologies, Inc.