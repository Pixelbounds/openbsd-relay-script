#!/bin/sh

is_relay_running() {
    relayrunning=$(ps auxwww | grep './portal' | grep -v grep)
    if [ -n "$relayrunning" ]; then
        echo "You are currently running a Portal relay. $relayrunning. After the script has finished configuring Portal remember to close processes running on a different port"
        return 0
    else
        echo "No relay detected in system processes, continuing..."
        return 1
    fi
}

is_relay_running

echo "Would you like to set up a Portal relay? (1 for yes, 0 for no)"
read relayconnection

if [ "$relayconnection" -eq 1 ]; then
    echo "Would you like to change the port of the relay, default port is 8080? (1 for yes, 0 for no)"
    read relayconfig
    if [ "$relayconfig" -eq 1 ]; then
        echo "Please select between 1024 - 65535 (Don't select an already open port)"
        read portselection
        while [[ -z $portselection || "$portselection" -gt 65535 || "$portselection" -lt 1024 ]]; do
            echo "Invalid input, please select a port between 1024 - 65535"
            read portselection
        done
        sed -i "3s/.*/port_relay_serve: $portselection/" "/home/$USER/.config/portal/config.yml"
        echo "Port $portselection configured for Portal"
        echo "Would you like to run the relay on port $portselection?"
        read startrelay
        if [ "$startrelay" -eq 1 ]; then
            cd /home/$USER/portal/
            nohup ./portal serve --port $portselection &
            echo "Relay started on port $portselection"
            exit 0
        else
            echo "Invalid input or user aborted script, closing."
            exit 0
        fi
    else
        echo "User aborted script, closing!"
        exit 0
    fi
elif [ "$relayconnection" -eq 0 ]; then
    echo "User aborted script, closing..."
    exit 0
else
    echo "Invalid input, closing..."
    exit 1
fi
