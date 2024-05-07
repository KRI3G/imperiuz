#!/bin/bash

#########################################
#  This is a self installing script for #
# Imperiuz, an SSH port forward manager.#
# Hope it proves useful to you.         #
#########################################

# - Functions

function genImperator {
	echo hello
}

function genCenturion {
	echo hello
}



# - Check if user is root
if [[ "$EUID" -ne 0 ]]; then
	echo "ERROR: Please run as root" >&2
	exit 2
fi

# === Installation ===

# Printing out Label
echo
echo "Welcome to Imperiuz (v2)"
echo -e "\e[33m==============================================================\e[0m"
echo -e "\e[33m|\e[0m\e[31m _____ _______  _____  _______  ______ _____ _     _ ______ \e[0m\e[33m|\e[0m"
echo -e "\e[33m|\e[0m\e[31m   |   |  |  | |_____] |______ |_____/   |   |     |  ____/ \e[0m\e[33m|\e[0m"
echo -e "\e[33m|\e[0m\e[31m __|__ |  |  | |       |______ |    \_ __|__ |_____| /_____ \e[0m\e[33m|\e[0m"
echo -e "\e[33m==============================================================\e[0m"
echo

# Prompt user for config options
# --- note to self, maybe prompt for custom port range?
echo -e "\e[4mPlease answer the following questions for your Imperiuz installation:\e[0m"
read -p "Romulus hostname: " -r ROMULUS_HOSTNAME
read -p "Romulus SSH Port: " -r ROMULUS_PORT
read -p "Romulus username: " -r ROMULUS_USERNAME

echo
echo -e "\e[1m$ROMULUS_USERNAME@$ROMULUS_HOSTNAME:$ROMULUS_PORT\e[0m"
read -p "Is Romulus' SSH information correct (y/n): " -n 1 -r CHECK
if [[ ! $CHECK =~ ^[Yy] ]]
then
	echo
	echo "ERROR: Please provide correct information next time" >&2
	exit 2
fi
echo

# - Create appropiate folder
echo
echo -e "\e[4m--- Creating Config Folder\e[0m"
mkdir -pv /etc/imperiuz/
mkdir -pv /var/lib/imperiuz/
echo "+ Done!"

# - Create config file
echo
echo -e "\e[4m--- Generating Config File\e[0m"
CONFIG=/etc/imperiuz/imperiuz.conf
touch $CONFIG
echo "# Port Imperator will listen on. Default is 7700/TCP" | tee $CONFIG #Notice the missing -a flag here
echo "Port 7700" | tee -a $CONFIG
echo "# Romulus Hostname. Can be IP or FQDN" | tee -a $CONFIG
echo "RomulusHostname $ROMULUS_HOSTNAME" | tee -a $CONFIG
echo "# Romulus SSH Port" | tee -a $CONFIG
echo "RomulusPort $ROMULUS_PORT" | tee -a $CONFIG
echo "# Romulus SSH Username" | tee -a $CONFIG
echo "RomulusUsername $ROMULUS_USERNAME" | tee -a $CONFIG


echo "+ Done!"

# - Create connection (((database)))
echo
echo -e "\e[4m--- Creating active connections database\e[0m"
DATA=/var/lib/imperiuz/connections
touch $DATA

echo "+ Done!"

#awk '/Port/ { if($1 != "#"){print $2;exit;} }' /etc/imperiuz/imperiuz.conf
# - Generate Imperator program
echo
echo -e "\e[4m--- Generating Imperator Program\e[0m"

echo "+ Done!"

# - Create Imperius systemd service
echo
echo -e "\e[4m--- Creating Imperius systemd service\e[0m"

echo "+ Done!"

# - Generating Centurion script
echo
echo -e "\e[4m--- Generating Centurion Script\e[0m"

echo "+ Done!"
