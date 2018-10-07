grafana_repo:
    pkgrepo.managed:
        -   humanname: grafana
        -   name: deb https://packagecloud.io/grafana/stable/debian/ stretch main
        -   file: /etc/apt/sources.list.d/grafana.list
        -   key_url: https://packagecloud.io/gpg.key
        -   refresh: True
        
install_grafana:
    pkg.installed:
        -   name: grafana

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
        -   profile:
                grafana_url: http://10.0.2.15:3000
                grafana_user: admin
                grafana_password: admin

#add_grafana_user:
    #grafana4_user.present:
        #-   name: 'sumgan'
        #-   password: 'passw0rd'
        #-   email: 'sumgan@localhost'
        #-   is_admin: True
        #-   fullname: 'Artur Nizamutdinov'
        #-   profile:
                #grafana_url: http://10.0.2.15:3000
                #grafana_user: admin
                #grafana_password: gadmin

#add_grafana_org:
    #grafana4_org.present:
        #-   name: 'TestOrg'
        #-   users:
                #sumgan: Admin
        #-   profile:
                #grafana_url: http://10.0.2.15:3000
                #grafana_user: admin
                #grafana_password: gadmin
