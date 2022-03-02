#!/bin/bash
# ----------------------------------------------------------------#
# Script Name:   "zabbix_agent2_install.sh"
# Description:   Install zabbix agent in Linux servers (CentOS).
# Site:          https://sevenit.com.br
# ----------------------------------------------------------------#
# Usage:         
#       $ ./zabbix_agent_install.sh
# ----------------------------------------------------------------#
#Server data
zbdir=/etc/zabbix/
zbconf=/etc/zabbix/zabbix_agent2.conf
echo -n "Digite o nome do seu Hostname: "
read hostname
#echo -n "Digite o endereço IP Zabbix Server: "
#read server
#Install zabbix agent
yum install -y wget
wget wget https://repo.zabbix.com/zabbix/5.4/rhel/7/x86_64/zabbix-agent2-5.4.10-1.el7.x86_64.rpm
rpm -i zabbix-agent2-5.4.10-1.el7.x86_64.rpm
yum install -y zabbix-agent2
#Configuration
echo $'Configure agent'
cd $zbdir
cp $zbconf $zbconf.ORIG
echo "" > $zbconf
PidFile=/var/run/zabbix/zabbix_agent2.pid
LogFile=/var/log/zabbix/zabbix_agent2.log
LogFileSize=0
# DebugLevel=3
##### Passive checks related
Server=10.18.32.10
##### Active checks related
ServerActive=10.18.32.10
Hostname=$hostname
# RefreshActiveChecks=120
### Option: PersistentBufferPeriod
# PersistentBufferPeriod=1h
############ ADVANCED PARAMETERS #################
### Option: Timeout
Timeout=30
### Option: Include
Include=/etc/zabbix/zabbix_agent2.d/*.conf
####### USER-DEFINED MONITORED PARAMETERS #######
UnsafeUserParameters=1
### Option: UserParameter
# UserParameter=
ControlSocket=/tmp/agent.sock
### Option: AllowKey
### Option: DenyKey
# DenyKey=system.run[*]
AllowKey=system.run[*]
" > /etc/zabbix/zabbix_agent2.conf

#Start service zabbix agent
systemctl start zabbix-agent2
systemctl enable zabbix-agent2
exit
