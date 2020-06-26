#!/bin/bash

#Start docker container (this is the process which we want to log the ram used from)
#Ampersand used to run in background so other commands can be executed before this one finishes
docker run hello-world &

#Get PID from last command
pid=$!


while true
do
	#Get RAM usage of process with specific PID
	ram_used=$(ps -p $pid -o rss=  | awk '{print $1}')

	#If $ram_used is empty, exit loop
 	[[ ! -z $ram_used ]] || break

	#Print ram usage and append to file
	echo "$ram_used" | tee -a /home/ivan/Desktop/ramlog.txt

	#Pause one second
	sleep 1
done
