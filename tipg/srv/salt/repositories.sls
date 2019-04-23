influx-repo:
    pkgrepo.managed:
        -   humanname: influx
        -   name: deb https://repos.influxdata.com/ubuntu xenial stable
        -   file: /etc/apt/sources.list.d/influx.list
        -   key_url: https://repos.influxdata.com/influxdb.key
        -   refresh: True
