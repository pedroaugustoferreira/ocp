#!/bin/bash -l
user=pedro
password=master
dir_temp=/tmp

login()
{
        oc login -u "$user" -p "$password" https://opc-dev-int.sascar.com.br > /dev/null
}

get_pods()
{
        oc get pods -o wide --all-namespaces
}

get_pvc()
{
        oc get pvc --all-namespaces -o wide
}



get_pods_volume()
{
        for namespaces_pod in $(awk '{print $1";"$2";"$8}' /tmp/pods|grep -v NAMESPACE)
        do
                namespaces=$(echo $namespaces_pod|cut -d";" -f1 )
                pod=$(echo $namespaces_pod|cut -d";" -f2 )
                node=$(echo $namespaces_pod|cut -d";" -f3 )
                oc -n "$namespaces" describe pod $pod |egrep -A 1 PersistentVolumeClaim|grep ClaimName|awk '{print "'$namespaces';'$pod';'$node';"$0}'|sed 's/ClaimName://g'|sed 's/ //g'
        done

}

join_pods_volume_pvc()
{
        for info in $(cat $dir_temp/pods_volume);
        do
                pvc=$(echo $info|cut -d";" -f4)
                cat $dir_temp/pvc|egrep $pvc|awk '{print "'$info';"$0}'
        done|tr -s ' ' ';'
}

get_volumepath_pods_volume_pvc()
{
        for info in $(cat $dir_temp/pods_volume_pvc);
        do
                pv=$(echo $info|cut -d";" -f8)
                oc describe pv $pv|egrep VolumePath|sed 's/VolumePath://g'|awk '{print "'$info';"$0}'
        done|sed 's/ //g'
}


login
get_pods |tee  $dir_temp/pods
get_pvc |tee  $dir_temp/pvc
get_pods_volume |tee $dir_temp/pods_volume
join_pods_volume_pvc |tee $dir_temp/pods_volume_pvc
get_volumepath_pods_volume_pvc | tee $dir_temp/get_volumepath_pods_volume_pvc

echo " "
echo "Report $dir_temp/get_volumepath_pods_volume_pvc"
