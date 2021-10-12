# echo "需要的参数">>.bashrc


echo "echo "net.core.somaxconn = 262144">>/etc/sysctl.conf
echo "echo "net.core.echo "netdev_max_backlog = 262144">>/etc/sysctl.conf
echo "echo "net.core.wmem_default = 8388608">>/etc/sysctl.conf
echo "net.core.rmem_default = 8388608">>/etc/sysctl.conf
echo "net.core.rmem_max = 16777216">>/etc/sysctl.conf
echo "net.core.wmem_max = 16777216">>/etc/sysctl.conf
echo "net.ipv4.echo "netfilter.ip_conntrack_max = 131072">>/etc/sysctl.conf
echo "net.ipv4.echo "netfilter.ip_conntrack_tcp_timeout_established = 180">>/etc/sysctl.conf
echo "net.ipv4.route.gc_timeout = 20">>/etc/sysctl.conf
echo "net.ipv4.ip_conntrack_max = 819200">>/etc/sysctl.conf
echo "net.ipv4.ip_local_port_range = 10024  65535">>/etc/sysctl.conf
echo "net.ipv4.tcp_retries2 = 5">>/etc/sysctl.conf
echo "net.ipv4.tcp_fin_timeout = 30">>/etc/sysctl.conf
echo "net.ipv4.tcp_syn_retries = 1">>/etc/sysctl.conf
echo "net.ipv4.tcp_synack_retries = 1">>/etc/sysctl.conf
echo "net.ipv4.tcp_timestamps = 0">>/etc/sysctl.conf
echo "net.ipv4.tcp_tw_recycle = 1">>/etc/sysctl.conf
echo "net.ipv4.tcp_tw_len = 1">>/etc/sysctl.conf
echo "net.ipv4.tcp_tw_reuse = 1">>/etc/sysctl.conf
echo "net.ipv4.tcp_keepalive_time = 120">>/etc/sysctl.conf
echo "net.ipv4.tcp_keepalive_probes = 3">>/etc/sysctl.conf
echo "net.ipv4.tcp_keepalive_intvl = 15">>/etc/sysctl.conf
echo "net.ipv4.tcp_max_tw_buckets = 36000">>/etc/sysctl.conf
echo "net.ipv4.tcp_max_orphans = 3276800">>/etc/sysctl.conf
echo "net.ipv4.tcp_max_syn_backlog = 262144">>/etc/sysctl.conf
echo "net.ipv4.tcp_wmem = 8192 131072 16777216">>/etc/sysctl.conf
echo "net.ipv4.tcp_rmem = 32768 131072 16777216">>/etc/sysctl.conf
echo "net.ipv4.tcp_mem = 94500000 915000000 927000000">>/etc/sysctl.conf

echo "ulimit -c unlimited">>.bashrc
echo "ulimit -s unlimited">>.bashrc
echo "ulimit -SHn 65535">>.bashrc
echo "ulimit -S -c 0">>.bashrc
echo "export LC_ALL=C">>.bashrc
