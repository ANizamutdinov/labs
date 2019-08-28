grafana_repo:
    pkgrepo.managed:
        -   humanname: grafana
        -   name: deb https://packages.grafana.com/oss/deb stable main
        -   file: /etc/apt/sources.list.d/grafana.list
        -   key_url: https://packages.grafana.com/gpg.key
        -   refresh: True
        
install_grafana:
    pkg.installed:
        -   name: grafana
        -   skip_verify: True

launch_grafana:
    service.running:
        -   name: grafana-server
        -   enable: True
        -   reload_modules: True
        
/etc/grafana/grafana.ini:
    file.managed:
        -   source: salt:///etc/grafana/grafana.ini
        -   user: root
        -   group: root
        -   mode: 644
        -   watch_in:
            -   service: grafana-server

sleep:
    cmd.run:
        -   name: sleep 10

add_grafana_user:
    grafana4_user.present:
        -   name: 'sumgan'
        -   password: 'passw0rd'
        -   email: 'sumgan@localhost'
        -   is_admin: True
        -   fullname: 'Artur Nizamutdinov'
        -   require:
            -   cmd: sleep
        -   profile:
                grafana_url: http://10.0.2.15:3000
                grafana_user: admin
                grafana_password: admin

add_grafana_org:
    grafana4_org.present:
        -   name: 'TestOrg'
        -   users:
                sumgan: Admin
        -   require:
            -   cmd: sleep
        -   profile:
                grafana_url: http://10.0.2.15:3000
                grafana_user: admin
                grafana_password: admin

add_influx_datasource:
    grafana4_datasource.present:
        -   name: influxdb
        -   type: influxdb
        -   url: http://192.168.1.12:8086
        -   access: proxy
        -   database: telegraf
        -   user: grafana
        -   password: somepassword
        -   is_default: True
        -   require:
            -   cmd: sleep
        -   profile:
                grafana_url: http://10.0.2.15:3000
                grafana_user: admin
                grafana_password: admin
