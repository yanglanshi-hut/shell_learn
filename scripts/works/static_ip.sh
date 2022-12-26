#!/bin/bash
#描述 ：通过交互式将动态获取的ip地址静态化
#作者 ：杨兰仕

read -p "请输入ip地址：" ip
ping -c 1 $ip  > /dev/null 2>&1

if [ $? -eq 0 ]
then 
    echo "当前ip已经存在！请重新设置！"
    exit 1
else
    echo "这个ip可以使用！"
fi


#获取网关
gw=`echo $ip | awk -F "." '{print $1"."$2"."$3"."2}'`

#获取网卡名称
NAME=`ifconfig | head -1 | awk -F ":" '{print $1}'`

#获取ip最后一位
LAST=`echo $ip | awk -F '.' '{print $4}'`

cat > /etc/sysconfig/network-scripts/ifcfg-$NAME <<EOF
TYPE=Ethernet
NAME=$NAME
DEVICE=$NAME
ONBOOT=yes
BOOTPROTO=static
IPADDR=$ip
NETMASK=255.255.255.0
GATEWAY=$gw
DNS1=8.8.8.8
EOF

hostnamectl --static set-hostname server-$LAST
systemctl restart network