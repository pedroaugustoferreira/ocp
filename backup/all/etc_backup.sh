#!/bin/bash -l
# mkdir /backup
# lvcreate -L+1G --name backup vg00
# mkfs.ext4 /dev/vg00/backup
# /dev/mapper/vg00-backup    /backup                    ext4    defaults        1 2
# mount /backup
# cd /backup
# wget https://raw.githubusercontent.com/pedroaugustoferreira/ocp/master/backup/all/etc_backup.sh
# chmod +x etc_backup.sh
# 0 1 1,15 * * /backup/etc/etc_backup.sh  &> /backup/etc/etc_backup.log


# https://docs.openshift.com/container-platform/3.11/day_two_guide/environment_backup.html#creating-master-backup_environment-backup

. /root/.bashrc
cd /backup/etc
dir=$(date +%d%m)
rm -rf $dir &> /dev/null
mkdir $dir 2> /dev/null

cd $dir
cp -rp /etc .
rpm -qa | sort &> packages.txt

cd ../
tar -czf "${dir}.tar.gz" "${dir}"
rm -rf ${dir}
