#!/bin/bash

USERADD_NUM=130
USERADD_NAME="test"

if [ `id -u` -ne "0" ];then
	echo " root !"
	exit 1
fi


if [ "$1" == "del" ];then
	for i in `seq ${USERADD_NUM}`
	do
		userdel -r ${USERADD_NAME}_${i}
	done

	exit 0
fi

for i in `seq ${USERADD_NUM}`
do
	useradd ${USERADD_NAME}_${i}
	ret=$?
	if [ "${ret}" -ne "0" ];then
		echo "useradd faild ! num= ${i}"
	fi
done


