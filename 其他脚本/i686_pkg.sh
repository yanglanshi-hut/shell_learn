#!/bin/bash

LOG_FILE="./i686_pkg.ret"
CMD_FLAG=" --downloadonly "

#####################################################

bar="*"
arr=("|" "/" "-" "\\")
#####################################################

if [ "`id -u`" -ne "0" ];then
	echo "root!!!"
	exit 1
fi

if [ "$#" -eq "0" ];then
	echo "Fail: Can't rpm file. Ex $0 /XXX/rpm.txt"
	exit 1
fi

RPM_FILE=$1
if [ "${RPM_FILE:0:1}" != "/" ] && [ "${RPM_FILE:0:1}" != "." ] ;then
	echo "Fail: ${RPM_FILE} not find !"
	exit 2
fi

if [ ! -f "${RPM_FILE}" ] ;then
	echo "Fail: ${RPM_FILE} is not file !"
	exit 2
fi

num_pkg=0
SPEED=0
tspeed=${SPEED}
num_pkg_sum=$(awk 'END {print NR}' ${RPM_FILE})
echo $num_pkg_sum
echo -n > ${LOG_FILE}

while read rpm_pkg
do
	let num_pkg++
	rpm_pkg_deal=${rpm_pkg}
	
	if [ -n "$(echo ${rpm_pkg_deal} | grep ".i686$")" ];then
		if [ -n "$(echo ${rpm_pkg_deal} | grep "\-[0-9]")" ];then
			rpm_pkg_deal=${rpm_pkg_deal%%-[0-9]*}.i686
		fi
	else
		if [ -n "$(echo ${rpm_pkg_deal} | grep "\-[0-9]")" ];then
			rpm_pkg_deal=${rpm_pkg_deal%%-[0-9]*}.i686
		else
			rpm_pkg_deal=${rpm_pkg_deal}.i686
		fi
	fi

	yum install ${rpm_pkg_deal} ${CMD_FLAG}  >> ${LOG_FILE} 2>&1

        let SPEED=num_pkg*100/num_pkg_sum
        if [ "${tspeed}" != "${SPEED}" ];then
                tspeed=${SPEED}
                tbar=""
                while [ ${tspeed} -gt "0" ]
                do
                        tbar+=${bar}
                        let tspeed--
                done
                tspeed=${SPEED}
        fi
        let index=num_pkg%4
        printf " [ %-100s ] [ %d%% ] [%d / %d][%c] \r" "$tbar" "$tspeed" "$num_pkg" "$num_pkg_sum" "${arr[$index]}"	

done < ${RPM_FILE}
echo ""
