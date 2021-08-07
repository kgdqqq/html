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


pip install SomePackage -i https://pypi.tuna.tsinghua.edu.cn/simple


yum clean all  &&  sudo yum makecache
`
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
yum -y install cobbler cobbler-web httpd tftp-server pykickstart rsyncd tftpd debmirror fence-agents xinetd dhcp




echo  "修改cobbler配置文件..."

echo "修改server的ip地址为本机ip"
sed -i 's/^server: 127.0.0.1/server: 10.172.16.29/' /etc/cobbler/settings 

echo "设置tftp的ip地址为本机ip"
sed -i 's/^next_server: 127.0.0.1/next_server: 10.172.16.29/' /etc/cobbler/settings 

echo  "修改default_password_crypted参数..."
sed -ri 's/^(default_password_crypted: ).*/\1"$1$root$ZTOnMEdLa1OCXrxQgE1H80"/' /etc/cobbler/settingssystemctl restart cobblerd

echo  "修改配置文件，cobbler是否控制dhcp  0不控制 1控制"
sed -i '/^manage_dhcp/s/0/1/g' /etc/cobbler/settings 
sed -n '/^manage_dhcp/p' /etc/cobbler/settings 

echo  "tftp"
sed -i '/disable/s/yes/no/g' /etc/xinetd.d/tftp 


echo  "注释/etc/debmirror.conf文件中的@dists="sid";一行"

sed -i 's/@dists="sid";/#@dists="sid";/' /etc/debmirror.conf

echo  "注释/etc/debmirror.conf文件中的@arches="i386";一行"

sed -i 's/@arches="i386";/#@arches="i386";/' /etc/debmirror.conf


#版本问题的 修改  vi /usr/bin/pip





echo  "python-pip"
yum install python-pip

pip install --upgrade pip


echo  " 下载缺失文件 "

cobbler get-loaders

echo  "pxelinux menu "
rm /var/lib/tftpboot/pxelinux.0
\cp /usr/share/syslinux/pxelinux.0  /var/lib/tftpboot/ 
\cp /usr/share/syslinux/menu.c32  /var/lib/tftpboot/

echo  "修改dhcp配置文件..."




echo "启动rsyncd..."
systemctl start httpd.service && systemctl enable httpd.service
systemctl start httpd.service && systemctl enable httpd.service


echo "启动rsyncd..."
systemctl start tftp.service && systemctl enable tftp.service
systemctl start tftp.service && systemctl restart tftp.service

echo "启动Cobbler..."
systemctl start cobblerd.service && systemctl enable cobblerd.service
systemctl start cobblerd.service && systemctl restart cobblerd.service

echo "启动rsyncd..."
systemctl start rsyncd.service && systemctl enable rsyncd.service
systemctl start rsyncd.service && systemctl restart rsyncd.service

echo "开启httpd"
systemctl start httpd.service && systemctl enable httpd.service
systemctl start httpd.service && systemctl enable httpd.service

yum clean all
#rpm --rebuilddb

echo " tail /var/log/messages  查看cobbler端的日志看具体情况"

cobbler check

echo  " 自动安装机器的状态"
#cobbler status

echo  "启动xinetd"
systemctl start xinetd.service && systemctl enable xinetd.service
systemctl enable xinetd.service && systemctl restart xinetd.service

echo  " 将光盘挂载到/mnt中"
mount /dev/cdrom /mnt/centos
echo  " 将光盘挂载到/mnt中"
# mount -t iso9660 /centos7.iso  /home/image/CentOS-7-x86_64-Minimal-1908

cobbler import --path=/mnt/centos --name=Centos7 --arch=x86_64


echo  " 安装dhcp代理"
yum install -y  dhcp

echo  "检查cobbler dhcp "
grep '^manage_dhcp' /etc/cobbler/settings

echo  " 启动dhcp"
systemctl start dhcpd.service && systemctl enable dhcpd.service
systemctl enable dhcpd.service && systemctl restart dhcpd.service


echo  " 为避免发生未知问题，先把服务端所有服务重启"
systemctl restart dhcpd.service && systemctl restart dhcpd.service
systemctl restart cobblerd.service && systemctl restart cobblerd.service
systemctl restart tftp.service && systemctl restart tftp.service
systemctl restart rsyncd.service && systemctl restart rsyncd.service
systemctl restart httpd.service && systemctl restart httpd.service
systemctl restart xinetd.service && systemctl restart xinetd.service
