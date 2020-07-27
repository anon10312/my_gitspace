#!/bin/bash

if [ "$1" == "" ]; then
	echo ""
	echo "Error: You Must Define A Target Ip"
	echo "Example: nmap_custom 192.168.1.5"
	echo ""
	exit 1
fi

mkdir nmap
cd nmap

echo ""
echo "Looking For Open Ports!"
nmap -sS -T4 -p- $1 -oN nmap.nmap
PORTS=$(cat nmap.nmap | grep open | cut -d / -f 1 | tr '\n' ','| sed 's/.$//')
echo ""
echo "Open Ports Found: $PORTS"
echo ""
echo "Identifying Running Services And Target OS"
nmap -sS -T4 -p $PORTS -A -oA nmap $1
echo ""
echo "Building A Pretty HTML Page"
xsltproc nmap.xml > nmap.html
echo ""
echo "Done"
echo ""

cd ..
