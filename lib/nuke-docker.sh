#!/bin/bash

CONTAINERS_RUNNING=$(docker ps -q)
if [ ! -z "${CONTAINERS_RUNNING}" ]; then
  echo "Killing running containers" 
  docker kill ${CONTAINERS_RUNNING}
fi

CONTAINERS_STOPPED=$(docker ps -a -q)
if [ ! -z "${CONTAINERS_STOPPED}" ]; then
  echo "Remove stopped containers" 
  docker rm ${CONTAINERS_STOPPED}
fi

CONTAINER_IMAGES=$(docker images -q)
if [ ! -z "${CONTAINER_IMAGES}" ]; then
  echo "Remove images" 
  docker rmi ${CONTAINER_IMAGES}
fi

