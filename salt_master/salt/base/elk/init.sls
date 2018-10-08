install-jre:
    pkg.installed:
        -   name: openjdk-8-jre
        
elasticsearch:
    pkg.installed:
        -   require:
            -   pkg: openjdk-8-jre

kibana:
    pkg.installed

launch-es:
    service.running:
        -   name: elasticsearch
        -   enabe: True
        -   require:
            -   pkg: elasticsearch

launch-kibana:
    service.running:
        -   name: kibana
        -   enabe: True
        -   require:
            -   pkg: kibana

/etc/kibana/kibana.yml:
    file.managed:
        -   source: "salt:///elk/files/kibana.yml"
        -   user: root
        -   group: root
        -   mode: 644
        -   watch_in:
            -   service: kibana
