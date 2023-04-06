#!/bin/sh -e

# remove the docker-network
docker network rm naturalist

services="naturforskaren populationstrend proxy"
for service in $services
do
    echo "Launching $service..."
    cd $service && make down && cd ..
    sleep 5
    echo "... done"
done
