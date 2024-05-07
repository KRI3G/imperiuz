#!/bin/bash

FORWARDPORT=7700
ROMULUSLAN=127.0.0.1

if [[ "${1,,}" == "forward" ]]; then 
	echo "$2 $3 $4" | nc $ROMULUSLAN $FORWARDPORT -q 1 -v
	echo "Sent forward command to target $2:$3 on Romulus port $4"
elif [[ "${1,,}" == "exit" ]]; then
	echo "EXIT" | nc $ROMULUSLAN $FORWARDPORT -q 1 -v
	echo "Sent 'EXIT' command"
elif [[ "${1,,}" == "status" ]]; then
	echo "STATUS" | nc $ROMULUSLAN $FORWARDPORT -q 1 -v
	echo "Sent 'STATUS' command"
fi
