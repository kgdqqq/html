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

echo "加速ssh连接.."
sed -i '/^#UseDNS/s/#UseDNS yes/UseDNS no/g' /etc/ssh/sshd_config

setenforce 0

echo "安装软件..."
yum -y install sudo yum-utils   unzip ntpdate passwd.x86_64  bzip*
yum install -y wget lrzsz  epel*  bash-completion
yum install -y net-snmp-perl net-snmp-utils sysstat
yum -y install OpenIPMI ipmitoolwqy-microhei-fonts
yum install net-snmp net-snmp-utils  lm-sensors -y
yum install -y net-tools.x86_64 vconfig  -y
yum install -y nano vim  curl net-tools lsof zip  -y

echo "生成缓存..."

yum clean all  &&  sudo yum makecache
systemctl stop firewalld.service && systemctl disable firewalld.service

echo "更新软件..."
yum update -y && yum upgrade -y
echo "软件更新完毕, OK"

echo "关闭红帽订阅..."
sed -i '/plugins/s/1/0/g' /etc/yum.conf
sed -i '/enabled/s/1/0/g' /etc/yum/pluginconf.d/fastestmirror.conf
echo "软件更新完毕, OK"

echo "Cockpit..."
yum install -y cockpit
sudo systemctl enable --now cockpit.socket && systemctl start cockpit.socket

echo "centos8 remove podman ..."
yum remove -y podman

echo "vimrc..."
mv /etc/vimrc /etc/vimrc.bak
wget https://kgdqqq.github.io/http/Yhua.sh && sh Yhua.sh

wget https://kgdqqq.github.io/http/WebGui.sh && sh WebGui.sh

#echo "基础包"

#wget -O /etc/sysctl.conf  https://kgdqqq.github.io/http/etc/s.txt

#修改系统编码
localectl set-locale LANG=zh_CN.UTF-8 source /etc/locale.conf 


