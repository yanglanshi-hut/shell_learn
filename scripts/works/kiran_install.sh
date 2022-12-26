#!/bin/bash
# This script is used to install kiran—desktop
#作者 ：杨兰仕

cp openEuler.repo /etc/yum.repo.d/openEuler.repo
yum makecache
yum install kiran-desktop -y
systemctl set-default graphical.target
reboot