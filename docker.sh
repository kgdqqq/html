#!/bin/bash
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun

mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://docker.mirrors.ustc.edu.cn"]
}
EOF
systemctl daemon-reload
systemctl restart docke
systemctl start docker.service
