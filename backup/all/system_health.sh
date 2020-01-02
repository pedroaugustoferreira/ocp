# mkdir /backup/system_health
# 

#!/bin/bash -l 
cd /backup/system_health
file=$(date "+%d%m")

netstat -nlp   &> ${file}.netstat.log
               
df -hT         &> ${file}.df.log
               
uname -a       &> ${file}.uname.log
               
uptime         &> ${file}.uptime.log
               
mount          &> ${file}.mount.log
               
ifconfig       &> ${file}.ifconfig.log
               
fdisk -l       &> ${file}.fdisk.log
               
ps aux         &> ${file}.ps.log
               
dmesg -c       &> ${file}.dmesg.log
               
systemctl      &> ${file}.systemctl.log

rpm -qa | sort &> ${file}.rpm.log

free -g        &> ${file}.free.log 


