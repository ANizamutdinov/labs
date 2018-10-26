#!/bin/sh
apt update
apt upgrade -y
apt install python htop tcpdump mc vim -y
wget https://www.foundationdb.org/downloads/5.2.5/ubuntu/installers/foundationdb-clients_5.2.5-1_amd64.deb
wget https://www.foundationdb.org/downloads/5.2.5/ubuntu/installers/foundationdb-server_5.2.5-1_amd64.deb
dpkg -i foundationdb-clients_5.2.5-1_amd64.deb
dpkg -i foundationdb-server_5.2.5-1_amd64.deb
mv /etc/foundationdb/foundationdb.conf /etc/foundationdb/foundationdb.conf.orig
FDB_ADD="$(ip -4 addr show enp0s8 | grep inet |cut -d ' ' -f6|cut -d '/' -f1)"
cat <<EOFS>> /etc/foundationdb/foundationdb.conf
## foundationdb.conf
##
## Configuration file for FoundationDB server processes
## Full documentation is available at
## https://foundationdb.com/documentation/configuration.html#foundationdb-conf

[fdbmonitor]
user = foundationdb
group = foundationdb

[general]
restart_delay = 60
cluster_file = /etc/foundationdb/fdb.cluster

## Default parameters for individual fdbserver processes
[fdbserver]
command = /usr/sbin/fdbserver
public_address = $FDB_ADD:\$ID
listen_address = $FDB_ADD:\$ID
datadir = /var/lib/foundationdb/data/\$ID
logdir = /var/log/foundationdb
# logsize = 10MiB
# maxlogssize = 100MiB
# machine_id = 
# datacenter_id = 
# class = 
# memory = 8GiB
# storage_memory = 1GiB

## An individual fdbserver process with id 4500
## Parameters set here override defaults from the [fdbserver] section
[fdbserver.4500]

[backup_agent]
command = /usr/lib/foundationdb/backup_agent/backup_agent
logdir = /var/log/foundationdb

[backup_agent.1]
EOFS

mv /etc/foundationdb/fdb.cluster /etc/foundationdb/fdb.cluster.orig
cat <<EOFC>> /etc/foundationdb/fdb.cluster
N9XJO3zE:tnH0tzDU9cpzPiPe0hUDNtxbdxvAYQA4@192.168.1.11:4500,192.168.1.12:4500,192.168.1.13:4500
EOFC
