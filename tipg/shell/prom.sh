#!/usr/bin/env bash

PROM_VERSION=2.9.1
NE_VERSION=0.17.0

sudo useradd --no-create-home --shell /bin/false prometheus
sudo useradd --no-create-home --shell /bin/false node_exporter

sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus

sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus

# download installation files for prometheus and node_exporter
wget -q https://github.com/prometheus/prometheus/releases/download/v$PROM_VERSION/prometheus-$PROM_VERSION.linux-amd64.tar.gz
tar xvf prometheus-$PROM_VERSION.linux-amd64.tar.gz

wget -q https://github.com/prometheus/node_exporter/releases/download/v$NE_VERSION/node_exporter-$NE_VERSION.linux-amd64.tar.gz
tar xvf node_exporter-$NE_VERSION.linux-amd64.tar.gz

# Locating Prometheus Files
sudo cp -vr prometheus-$PROM_VERSION.linux-amd64/prometheus /usr/local/bin/
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo cp -vr prometheus-$PROM_VERSION.linux-amd64/promtool /usr/local/bin/
sudo chown prometheus:prometheus /usr/local/bin/promtool

sudo cp -vr prometheus-$PROM_VERSION.linux-amd64/consoles /etc/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo cp -vr prometheus-$PROM_VERSION.linux-amd64/console_libraries /etc/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries

# Locating Node Exporter Files
sudo cp -vr node_exporter-$NE_VERSION.linux-amd64/node_exporter /usr/local/bin
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter

# Configuring Prometheus
sudo cat <<EOF > /etc/prometheus/prometheus.yml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9090']
  - job_name: 'node_exporter'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9100']
EOF

sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml

# Configuring systemd services
sudo cat <<EOF > /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
EOF

sudo cat <<EOF > /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable prometheus.service node_exporter.service
sudo systemctl start prometheus.service node_exporter.service
