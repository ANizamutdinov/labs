java_ppa:
    pkgrepo.absent:
        -   humanname: Java repo
        -   ppa: webupd8team/java
        -   refresh: true

java_install:
    pkg.installed:
        -   name: oracle-java8-installer
