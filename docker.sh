#!/bin/bash
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun

mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://docker.mirrors.ustc.edu.cn"]
}
EOF


curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose


systemctl daemon-reload
systemctl restart docke
systemctl start docker.service
systemctl enable docker.service
