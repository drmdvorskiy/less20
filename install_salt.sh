#!/usr/bin/env bash
echo -n "add repository ... "
for i in {2..4}; do
  ssh vagrant@192.168.6."${i}" 'sudo curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest/salt-archive-keyring.gpg && \
                        echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg arch=amd64] https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest focal main" | sudo tee /etc/apt/sources.list.d/salt.list && \
                        sudo apt-get update' &> /dev/null
done
echo "DONE"

echo -n "install salt-master ... "
ssh vagrant@192.168.6.2 'sudo apt-get install salt-master -y && \
                         sudo chmod o+w /etc/salt && \
                         sudo chmod o+w /etc/salt/master && \
                         sudo mkdir /srv/salt && sudo chmod o+w /srv/salt' &> /dev/null
echo "DONE"

echo -n "install salt-minions ... "
for j in {3..4}; do
  ssh vagrant@192.168.6."${j}" 'sudo apt-get install salt-minion -y && \
                                sudo chmod o+w /etc/salt/minion && \
                                echo "master: 192.168.6.2" > /etc/salt/minion && \
                                sudo systemctl restart salt-minion' &> /dev/null
done
echo "DONE"

echo -n "Configure master ... "
scp master vagrant@192.168.6.2:/etc/salt &> /dev/null
ssh vagrant@192.168.6.2 'sudo pkill salt-master && sudo salt-master -d'
echo "DONE"

echo -n "Copy sals files ... "
scp -p *.sls vagrant@192.168.6.2:/srv/salt/ &> /dev/null
echo "DONE"
