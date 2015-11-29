#!/bin/bash
#Simple motd script for Centos 5/6
#created by Vitalijus Ryzakovas

b=`tput bold`
n=`tput sgr0`
echo "Checking for system updates:"
while ps aux | grep -e [y]um > /dev/null; do echo -n .;sleep 1; done &
up=`yum -e0 -d0 check-update | awk '{print $1}'`
reset
echo -e "${b}Hostname:${n} `hostname` \t\t IP address: `/sbin/ifconfig venet0:0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}'`"
echo -e "Public IP address: $(/opt/whatismyip.sh)"
echo -e "${b}CPU load:${n} `cat /proc/loadavg | cut -d" " -f1-3`"
echo -e "${b}Uptime:${n} `uptime | cut -d" " -f 4-7 | cut -d"," -f1-2`"
echo -e "Free memorry: `cat /proc/meminfo | grep MemFree | awk {'print int($2/1000)'}` MB \t\t Total memory: `cat /proc/meminfo | grep MemTotal | awk {'print int($2/1000)'}` MB"
echo -e "${b}Available updates:${n} `if [[ ! -n "${up}" ]]; then echo "system up-to-date"; else echo $up; fi`\n"
df -h
echo -e "Proccess number: `cat /proc/loadavg | cut -d"/" -f2| cut -d" " -f1`\n"
echo -e "${b}Active sessions:${n} `w | tail -n +2`"
