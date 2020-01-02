# mkdir /backup/system_health;cd /backup/system_health;pwd
# wget --no-check-certificate https://raw.githubusercontent.com/pedroaugustoferreira/ocp/master/backup/all/system_health.sh;chmod +x system_health.sh;ls -la

## backup config
#0 1 1,15 * * /backup/etc/etc_backup.sh           &> /backup/etc/etc_backup.log
#0 2 * * * /backup/system_health/system_health.sh &> /backup/system_health/system_health.log
#* * * * * /backup/system_health/system_health.sh &> /backup/system_health/system_health.log

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


