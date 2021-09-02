mkdir /home/aria2
mkdir /home/downloads
mkdir /home/aria2/aria2-config
mkdir /home/aria2/script


wget -O /home/aria2/aria2-config/clean.sh https://kgdqqq.github.io/Other/aria2/clean.sh

wget -O /home/aria2/aria2-config/aria2.session https://kgdqqq.github.io/Other/aria2/aria2.session

wget -O /home/aria2/aria2-config/dht.dat https://kgdqqq.github.io/Other/aria2/dht.dat

wget -O /home/aria2/aria2-config/dht6.dat https://kgdqqq.github.io/Other/aria2/dht6.dat

wget -O /home/aria2/aria2-config/script/delete.sh https://kgdqqq.github.io/Other/aria2/delete.sh

wget -O /home/aria2/aria2-config/aria2.conf https://kgdqqq.github.io/Other/aria2/aria2.conf


wget -O /home/aria2/aria2-pro.yml https://kgdqqq.github.io/Other/aria2/aria2-pro.yml


docker-compose -f /home/aria2/aria2-pro.yml up -d



mkdir /home/qbittorrent

mkdir /home/qbittorrent/config

wget -O /home/qbittorrent/qbittorrent.yml https://kgdqqq.github.io/Other/qbittorrent/qbittorrent.yml

docker-compose -f /home/qbittorrent.yml up -d





