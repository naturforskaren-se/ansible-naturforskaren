#!/bin/sh -e
NOW=`date +"%Y-%m-%d"`
echo "$NOW : test script for reboot " >> reboot_logger.log

services="docker-naturforskaren naturalist-populationstrend naturalist-proxy"
for service in $services
do
    echo "Launching $service..."
    cd $service && make up && cd ..
    sleep 5
    echo "... done"
done
