elastic_repo:
    pkgrepo.managed:
        -   humanname:  Elastic
        -   name: deb https://artifacts.elastic.co/packages/6.x/apt stable main
        -   key_url: https://artifacts.elastic.co/GPG-KEY-elasticsearch
        -   file: /etc/apt/sources.list.d/elastic.list
        -   refresh: True
