#! /usr/local/bin/bash
if [ ps | grep '.portal' -eq true ]
	then
		echo "You are currently running a Portal relay:" && ps | grep "./portal"
	else
		echo "No relay detected in system processes, continuing..."
fi


echo "Would you like to set up a Portal relay? (1 for yes, 0 for no)"
read relayconnection

if [ $relayconnection -eq 1 ]
	then
	cat /home/$USER/.config/portal/config.yml
	
fi

if [ $relayconnection -eq 0 ]
then
	echo "User aborted script, closing..."
fi

# PID for portal serve is 37225