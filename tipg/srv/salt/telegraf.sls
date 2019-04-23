install-telegraf:
    pkg.installed:
        -   name: telegraf

launch-telegraf:
    service.running:
        -   name: telegraf
        -   enable: True

/etc/telegraf/telegraf.conf:
    file.managed:
        -   source: salt://etc/telegraf/telegraf.conf
        -   user: root
        -   group: root
        -   mode: 644
        -   watch_in:
            -   service: telegraf
