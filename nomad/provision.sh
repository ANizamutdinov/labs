#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive
apt-get -qq update && apt-get -qq -y upgrade && apt-get -qq -y install curl htop tcpdump unzip

### Install nomad
if [[ ! -e /usr/bin/nomad ]]; then
  curl -sO https://releases.hashicorp.com/nomad/0.10.4/nomad_0.10.4_linux_amd64.zip
  unzip -o nomad_* &&  mv -v /home/vagrant/nomad /usr/local/bin/nomad
  nomad -autocomplete-install
  complete -C /usr/local/bin/nomad nomad
  mkdir --parents /opt/nomad
  echo "$(nomad -version | cut -d ' ' -f 1-2)" "has been installed"
### Set config
  if [[ ! -e /etc/nomad.d ]]; then
    mkdir /etc/nomad.d
  fi
  if [[ ! -e /etc/nomad.d/nomad.hcl ]]; then
    cp -v /vagrant/nomad.hcl /etc/nomad.d/nomad.hcl
  fi
  if [[ ! -e /etc/systemd/system/nomad.service ]]; then
    cp -v /vagrant/nomad.service /etc/systemd/system/nomad.service
  fi
  sudo systemctl daemon-reload
  echo "$(nomad -version | cut -d ' ' -f 1-2)" "has been configured"
fi;

### Start Nomad
sudo systemctl start nomad
echo "$(nomad -version | cut -d ' ' -f 1-2)" "is running!"