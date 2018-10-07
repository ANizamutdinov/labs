j_repo:
    pkgrepo.managed:
        -   humanname: Jenkins repo
        -   name: deb http://pkg.jenkins-ci.org/debian binary/
        -   file: /etc/apt/sources.list.d/jenkins.list
        -   key_url: http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key
        -   refresh: true
        
j_install:
    pkg.installed:
        -   name: jenkins
        
