install-nginx:
    pkg.installed:
        -   nginx

#configure_nginx:
    #file.managed:
        #source: "salt/base/nginx/files/nginx.conf"
        #user: "nginx"
        #group: "nginx"
        #mode: 644
