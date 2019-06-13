install_influx:
    pkg.installed:
        -   name: influxdb

launch_influx:
    service.running:
        -   name: influxdb
        -   enable: True

install_python_influx:
    pip.installed:
        -   name: influxdb
        -   require:
            -   pkg: python-pip
            -   pkg: influxdb
        -   reload_modules: True

add_influx_db:
    influxdb_database.present:
        -   name: telegraf
        -   require:
            -   pip: influxdb

add_dbuser_telegraf:
    influxdb_user.present:
        -   name: telegraf
        -   passwd: somepassword
        -   admin: False
        -   grants:
                telegraf: all
        -   require:
            -   pip: influxdb
            -   influxdb_database: telegraf
            
add_dbuser_grafana:
    influxdb_user.present:
        -   name: grafana
        -   passwd: somepass
        -   admin: False
        -   grants:
                telegraf: read
        -   require:
            -   pip: influxdb
            -   influxdb_database: telegraf
