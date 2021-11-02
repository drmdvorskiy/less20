#!/usr/bin/env bash
for i in {2..4}; do
  ssh vagrant@192.168.6."${i}" 'sudo curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest/salt-archive-keyring.gpg && \
                        echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg arch=amd64] https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest focal main" | sudo tee /etc/apt/sources.list.d/salt.list && \
                        sudo apt-get update'
done

ssh vagrant@192.168.6.2 'sudo apt-get install salt-master -y && \
                         sudo chmod o+w /etc/salt/master && \
                         echo "auto_accept: True" > /etc/salt/master &&\
                         sudo systemctl restart salt-master'

for j in {3..4}; do
  ssh vagrant@192.168.6."${j}" 'sudo apt-get install salt-minion -y && \
                                sudo chmod o+w /etc/salt/minion && \
                                echo "master: 192.168.6.2" > /etc/salt/minion && \
                                sudo systemctl restart salt-minion'
done
