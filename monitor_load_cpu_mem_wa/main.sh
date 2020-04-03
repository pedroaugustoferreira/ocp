#!/bin/bash -l
cd /home/pedro.ferreira.ext/.load
. /home/pedro.ferreira.ext/.login

oc adm top nodes > temp01
dt=$(date "+%d_%m_%y_%H_%M")


for i in $(cat temp01 |awk '{print $1}'|grep -v NAME);
do
        echo "$i - $(sudo ssh $i load)"
done > temp02

p1()
{
#echo -e "Data $(cat temp01|grep NAME)"
for i in $(cat temp01 |awk '{print $1}'|grep -v NAME);
do
	echo "$(cat temp01|grep $i) $(cat temp02|grep $i)"
done |awk '{print "'$dt'  "$0}'|tr -d '\015'|tr -s ' ' ' '
}

p1 |column -t >> data.log

# PODS
oc get pods --all-namespaces -o wide > temp03
oc adm top pods --all-namespaces > temp04


for i in $(cat temp03|tr -s ' ' ';');
do
pod=$(echo $i|cut -d";" -f2)
echo "$i $(cat temp04 |egrep " $pod "|tr -s ' ' ';')"
done| tr -s ' ' ';'|tr -s ';' ' '|awk '{print "'$dt'  "$0}'|grep -v NAMESPACE >> datapods.log
