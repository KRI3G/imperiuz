#!/bin/bash

# Get Parameters from config file
IMPERATORPORT=$(awk '/Port/ { if($1 != "#"){print $2;exit;} }' /etc/imperiuz/imperiuz.conf)
ROMULUSHOSTNAME=$(awk '/RomulusHostname/ { if($1 != "#"){print $2;exit;} }' /etc/imperiuz/imperiuz.conf)
ROMULUSPORT=$(awk '/RomulusPort/ { if($1 != "#"){print $2;exit;} }' /etc/imperiuz/imperiuz.conf)
ROMULUSUSERNAME=$(awk '/RomulusUsername/ { if($1 != "#"){print $2;exit;} }' /etc/imperiuz/imperiuz.conf)

ssh -fN -R $IMPERATORPORT:localhost:$IMPERATORPORT $ROMULUSUSERNAME@$ROMULUSHOSTNAME -p $ROMULUSPORT & IMPERATORCONNECTION=$(echo $!) 1>/dev/null \
&& echo "STATUS: Listening on port $IMPERATORPORT for Romulus at $ROMULUSUSERNAME@$ROMULUSHOSTNAME:$ROMULUSPORT"

#IMPERATORCONNECTION=$(echo $!)


echo "1|Target Hostname    2|Target Port    3|Romulus Port    4|Time established   || Imperator last started at $(date)" > /var/lib/imperiuz/connections


# Infinite while loop
while [[ 1 ]]
do

TARGET=$(nc -lp $IMPERATORPORT)
TARGETHOSTNAME=$(echo $TARGET | awk '{print $1}')
TARGETPORT=$(echo $TARGET | awk '{print $2}')
FORWARDPORT=$(echo $TARGET | awk '{print $3}')

if [[ "$TARGET" == "STATUS" ]]; then
	echo "$(date) | Working just fine" >> /home/cisco/imperator-log.txt
	echo "STATUS: Status query passed"
elif [[ "$TARGET" == "EXIT" ]]; then
	echo "EXIT: Received command to exit"
	kill $IMPERATORCONNECTION
	exit
else
	ssh -fN -R $FORWARDPORT:$TARGETHOSTNAME:$TARGETPORT $ROMULUSUSERNAME@$ROMULUSHOSTNAME -p $ROMULUSPORT \
	& 1>/dev/null && echo "FORWARD: Created remote forward to $TARGET on process $!"
	echo "$TARGETHOSTNAME   $TARGETPORT   $FORWARDPORT   $(date)" >> /var/lib/imperiuz/connections
fi

done
