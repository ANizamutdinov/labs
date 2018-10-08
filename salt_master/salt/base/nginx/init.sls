install-nginx:
    pkg.installed:
        -   name: nginx

/etc/nginx/sites-available/default:
    file.managed:
        -   source: "salt:///nginx/files/default"
        -   user: root
        -   group: root
        -   mode: 644
        -   watch_in:
            -   service: nginx

restart_nginx:
    service.running:
        -   name: nginx
        -   enable: true

install-filebeat:
    pkg.installed:
        -   name: filebeat
