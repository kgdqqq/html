#!/bin/bash
#关闭内核机制
#sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux && setenforce 0
if [[ $linux_release =~ $release_centos6 ]];then
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux
elif [[ $linux_release =~ $release_centos7 ]];then
sed -i "s#SELINUX=enforcing#SELINUX=disabled#g" /etc/selinux/config
fi

#获取当前系统的发行版本
VERSION=$(cat /etc/centos-release)

#提取当前系统的版本号
V_NUM=${VERSION:21:1}

BASE_REPO="/etc/yum.repos.d/CentOS-Base.repo"
ALI_REPO="http://mirrors.aliyun.com/repo/Centos-${V_NUM}.repo"

echo "备份当前软件源..."
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
echo "备份完成: /etc/yum.repos.d/CentOS-Base.repo.backup"
echo "下载阿里云镜像源..."
wget -O ${BASE_REPO} ${ALI_REPO} || curl -o ${BASE_REPO} ${ALI_REPO}
#补丁程序, 防止出现 Couldn't resolve host 'mirrors.cloud.aliyuncs.com' 信息
sed -i -e '/mirrors.cloud.aliyuncs.com/d' -e '/mirrors.aliyuncs.com/d' /etc/yum.repos.d/CentOS-Base.repo
echo "清除缓存..."
yum clean all
echo "缓存清除成功,OK"

echo "生成缓存..."
yum makecache
echo "生成缓存成功, OK"

echo "安装软件..."
yum -y install sudo yum-utils   unzip ntpdate
yum install -y wget lrzsz  epel*  bash-completion
yum install -y net-snmp-perl net-snmp-utils sysstat
yum -y install OpenIPMI ipmitoolwqy-microhei-fonts
yum install net-snmp net-snmp-utils  lm-sensors -y
yum install langpacks-zh_CN.noarch -y net-tools.x86_64 -y

yum clean all  &&  sudo yum makecache


echo "关闭dns查找."
sed -i '/^#UseDNS/s/#UseDNS yes/UseDNS no/g' /etc/ssh/sshd_config



echo "更新软件..."
yum update && yum upgrade -y
echo "软件更新完毕, OK"


echo "再次关闭防火墙..."
systemctl stop firewalld.service && systemctl disable firewalld.service
sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config 
sed -i 's/SELINUXTYPE=targeted/#&/' /etc/selinux/config	
setenforce 0






echo "安装Cobbler..."






