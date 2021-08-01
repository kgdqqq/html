#!/bin/bash
yum -y install sudo yum-utils   unzip 
yum install -y wget lrzsz  epel-release  bash-completion
yum install -y net-snmp-perl net-snmp-utils sysstat
yum -y install OpenIPMI ipmitoolwqy-microhei-fonts
yum install net-snmp net-snmp-utils  lm-sensors -y
yum install langpacks-zh_CN.noarch -y net-tools.x86_64
yum clean all  &&  sudo yum makecache
yum -y upgrade
systemctl stop firewalld.service && systemctl disable firewalld.service
sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config 
sed -i 's/SELINUXTYPE=targeted/#&/' /etc/selinux/config	
setenforce 0
sed -i '/^#UseDNS/s/#UseDNS yes/UseDNS no/g' /etc/ssh/sshd_config
ntpdate cn.pool.ntp.org
