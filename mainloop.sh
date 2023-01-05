#!/bin/bash

CONFIG_FILE=/app/config.cfg

#Outer loop for retry
while true
do
    echo "Building Configuration..."
    expect /app/build-config.exp $NOIP_USER $NOIP_PASS $NOIP_DOMAINS $NOIP_INTERVAL $CONFIG_FILE

    echo "Starting Updater..."
    /app/noip2-x86_64 -c $CONFIG_FILE

    #Inner loop checks for life
    while true
    do 
        o=$(/app/noip2-x86_64 -c $CONFIG_FILE -S 2>&1)
        echo $o
        if [[ "$o" != *"started as"* ]]; then
            echo "Process not detected as active. Restarting in 30 seconds..."
            sleep 30 # turns out if you just auto restart you'll get into an ugly infinite loop of restarting
            break
        fi

        echo "Healthcheck Success. Sleeping 60."
        sleep 60
    done
done
