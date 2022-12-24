#/bin/bash

DIR="/mnt/Packages"
SIGNATURE="Signature"
bar="*"
arr=("|" "/" "-" "\\")

NUM=0
FAIL_NUM=0
FILE_NUM=0
SPEED=0
TMP_SPEED=0

# ALL FILE NUM
FILE_NUM=`ls ${DIR}/*.rpm | wc -l`
#echo ${FILE_NUM}

for file in ${DIR}/*.rpm; do
	let NUM++
	let SPEED=NUM*100/FILE_NUM
	if [ "${TEM_SPEED}" != "${SPEED}" ];then
		TEM_SPEED=${SPEED}
		bar+="*"
	fi
	let index=NUM%4
	printf "[ %-100s ] [ %d%% ] [%c] \r" "$bar" "$SPEED" "${arr[$index]}"
		
#	echo "rpm -K -v ${file} | grep  ${SIGNATURE}"
	rpm -K -v ${file} | grep -q ${SIGNATURE}
	ret=$?
	if [ ${ret} -ne "0" ];then
		let FAIL_NUM++
		FAIL_NAME_FILE+=" ${FAIL_NUM}"
	fi
done

if [ ${FILE_NUM} -ne ${NUM} ];then
	echo "FAILED !!!!"
fi	

echo " "
echo Packages num : ${NUM}
echo No Signature num : ${FAIL_NUM}

if [ $FAIL_NUM -ne "0" ];then
	echo "${FAIL_NAME_FILE} no signature"

fi

