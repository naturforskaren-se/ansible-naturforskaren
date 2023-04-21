#!/bin/sh -e
NOW=`date +"%Y-%m-%d"`
echo "$NOW : script for reboot " >> reboot_logger.log

# create the docker-network
./naturforskaren/setup_docker_network.sh

services="naturforskaren populationstrend proxy"
for service in $services
do
    echo "Launching $service..."
    cd $service && make up && cd ..
    sleep 5
    echo "... done"
done

# Deploy the war-file to Wildfly
sleep 10
cd naturforskaren && make naturalist-deploy && cd ..
echo "deployed the war-file to naturforskaren"
