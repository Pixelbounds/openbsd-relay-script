#! /bin/bash
relayrunning=$(ps | grep './portal')
relayport=$(sed -n 4p /home/$USER/.config/portal/config.yml | grep -Eo '[0-7]{0,4}[0-9]{0,4}|65535')

if ps | grep -q './portal'
	then
		echo "You are currently running a Portal relay. $relayrunning"
	else
		echo "No relay detected in system processes, continuing..."
fi
echo "Would you like to set up a Portal relay? (1 for yes, 0 for no)"
read relayconnection
if [ $relayconnection -eq 1 ]
	then
	echo "Current configured port is $relayport"
	echo "Would you like to change the port of the relay? (1 for yes, 0 for no)"
	read relayconfig
	if [ $relayconfig -eq 1 ]
		then
		echo "Please select between 1024 - 65535 (Don't select an already open port)"
		read portselection
		while [[ -z $portselection ]]
			do
			echo "Input empty select a port between 1024 - 65535"
			read portselection
			if [[ $portselection -gt 65536 ]]
				then 
				echo "Port selection is greater than 65535, select a port between 1024 - 65535"
				read portselection
			fi
		done
		while [[ $portselection -gt 65536 ]]
			do
			echo "Input is greater than 65535, please select a port between 1024 - 65535"
			read portselection
			if [[ -z $portselection ]]
				then
				echo "Input empty select a port between 1024 - 65535"
				read portselection
			fi
		done
		sed -i "3s/.*/port_relay_serve: $portselection/" "/home/$USER/.config/portal/config.yml"
		echo "Port $portselection configured for Portal"
		echo "Would you like to run the relay on port $portselection?"
		read startrelay
			if [ $startrelay -eq 1 ]
				then
				cd /home/$USER/portal/
				nohup ./portal serve --port $relayport&
				echo "$relayrunning"
			else
				echo "Invalid input or user aborted script, closing."
			fi
	fi
	if [ $relayconfig -eq 0 ]
		then
		echo "User aborted script, closing!"
	fi
fi
if [ $relayconnection -eq 0 ]
then
	echo "User aborted script, closing..."
fi