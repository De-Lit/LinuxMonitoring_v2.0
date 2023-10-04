#!/bin/sh

nginx

while
    true
do
    bash /data/metrics.sh > /data/www/metrics
    sleep 5
done
