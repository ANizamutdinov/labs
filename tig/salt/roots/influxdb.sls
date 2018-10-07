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

add_telegraf_user:
    influxdb_user.present:
        -   name: telegraf
        -   password: somepassword
        -   admin: False
        -   grants:
                telegraf: all
        -   require:
            -   pip: influxdb
            -   influxdb_database: telegraf
            
add_grafana_user:
    influxdb_user.present:
        -   name: grafana
        -   password: somepass
        -   admin: False
        -   grants:
                telegraf: read
        -   require:
            -   pip: influxdb
            -   influxdb_database: telegraf
