#!/bin/bash -l
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
