#! /usr/local/bin/bash
echo "Do you want to start Portal relay on port:20371? (1 for yes, 0 for no)"
read relayconnection

if [ $relayconnection -eq 1 ]
then
	cd /home/dennis/portal/
	pwd
	nohup ./portal serve --port 20371&
	echo "Relay is up on port 20371 and running in background"
fi

if [ $relayconnection -eq 0 ]
then
	echo "User aborted script, closing..."
fi

