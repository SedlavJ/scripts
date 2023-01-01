#!/bin/bash

# Displays a variety of system information

finished=0
hostname=$(hostname)
red='\e[31m'
green='\e[32m'
blue='\e[34m'
clear='\e[0m'

function ColorRed() {
	echo -ne $red$1$clear
}

function ColorGreen() {
	echo -ne $green$1$clear
}

function ColorBlue() {
	echo -ne $blue$1$clear
}

function os_version() {
	clear
	echo ""
	echo "$(ColorGreen 'OS version on') $hostname$(ColorGreen ':') "
	echo "========================="
	cat /etc/os-release
	echo ""
}

function os_install_date() {
	clear
	echo ""
	echo "$(ColorGreen 'OS install date on') $hostname$(ColorGreen ':') "
	echo "=============================="
	sudo dumpe2fs 2>/dev/null $(mount | grep 'on \/ ' | awk '{print $1}') | grep 'Filesystem created:'
	echo "=============================="
	echo ""
}

function external_ip() {
	clear
	echo ""
	echo "$(ColorGreen 'External IP on') $hostname$(ColorGreen ':') "
	echo "=========================="
	curl ifconfig.me 
	echo ""
	echo "=========================="
	echo ""
}

function local_ip() {
	clear
	echo ""
	echo "$(ColorGreen 'Local IP on') $hostname$(ColorGreen ':') "
	echo "======================="
	hostname -I | awk '{print $1}'
	echo "======================="
	echo ""
}



while [ $finished -ne 1 ]
do
	echo ""
	echo "$(ColorGreen 'System Info')"
	echo ""
	echo "$(ColorGreen '[ 1 ]') OS version"
	echo "$(ColorGreen '[ 2 ]') Install Date"
	echo "$(ColorGreen '[ 3 ]') External IP"
	echo "$(ColorGreen '[ 4 ]') Internal IP"
	echo ""
	echo "$(ColorGreen '[ 5 ]') Exit"
	echo "$(ColorBlue 'Choose an option:') "
	read choice;
	case $choice in 
		1) os_version;;
		2) os_install_date;;
		3) external_ip;;
		4) local_ip;;
		5) finished=1;;
		*) echo ""; echo -e $red"Wrong option."; echo "";;
	esac
done
clear
