#!/bin/bash
yum -y update
yum -y install salt-api


foreman-installer --enable-foreman-plugin-salt --enable-foreman-proxy-plugin-salt

echo -e "Cmnd_Alias SALT = /usr/bin/salt, /usr/bin/salt-key" >> /etc/sudoers
echo -e "foreman-proxy ALL = NOPASSWD: SALT" >> /etc/sudoers
echo -e "saltuser ALL = NOPASSWD: ALL" >> /etc/sudoers
echo -e "Defaults:foreman-proxy !requiretty" >> /etc/sudoers

#insert into /etc/salt/master
echo -e "master_tops:" >> /etc/salt/master
echo -e "  ext_nodes: /usr/bin/foreman-node" >> /etc/salt/master

echo -e "ext_pillar:" >> /etc/salt/master
echo -e "  - puppet: /usr/bin/foreman-node" >> /etc/salt/master

echo -e "autosign_file: /etc/salt/autosign.conf" >> /etc/salt/master

echo -e "external_auth:" >> /etc/salt/master
echo -e "  pam:" >> /etc/salt/master
echo -e "    saltuser:" >> /etc/salt/master
echo -e "      - '@runner'" >> /etc/salt/master
echo -e "rest_cherrypy:" >> /etc/salt/master
echo -e "  port: 9191" >> /etc/salt/master
echo -e "  host: 0.0.0.0" >> /etc/salt/master
echo -e "  ssl_key: /var/lib/puppet/ssl/private_keys/foreman.example.com.pem" >> /etc/salt/master
echo -e "  ssl_crt: /var/lib/puppet/ssl/certs/foreman.example.com.pem" >> /etc/salt/master

touch /etc/salt/autosign.conf
chgrp foreman-proxy /etc/salt/autosign.conf
chmod g+w /etc/salt/autosign.conf

echo > /etc/salt/foreman.yaml
echo -e ":proto: https" >> /etc/salt/foreman.yaml
echo -e ":host: salt.localdomain" >> /etc/salt/foreman.yaml
echo -e ":port: 443" >> /etc/salt/foreman.yaml
echo -e ":ssl_ca: /var/lib/puppet/ssl/certs/ca.pem" >> /etc/salt/foreman.yaml
echo -e ":ssl_key: /var/lib/puppet/ssl/private_keys/foreman.example.com.pem" >> /etc/salt/foreman.yaml
echo -e ":ssl_cert: /var/lib/puppet/ssl/certs/foreman.example.com.pem" >> /etc/salt/foreman.yaml
echo -e ":timeout:  10" >> /etc/salt/foreman.yaml
echo -e ":salt:  /usr/bin/salt" >> /etc/salt/foreman.yaml
echo -e ":upload_grains:  true" >> /etc/salt/foreman.yaml

useradd -p $(openssl passwd -1 saltpassword) saltuser
echo > /etc/foreman-proxy/settings.d/salt.yml
echo -e ":use_api: true" >> /etc/foreman-proxy/settings.d/salt.yml
echo -e ":api_auth: pam" >> /etc/foreman-proxy/settings.d/salt.yml
echo -e ":api_url: https://salt.localdomain:9191" >> /etc/foreman-proxy/settings.d/salt.yml
echo -e ":api_username: saltuser" >> /etc/foreman-proxy/settings.d/salt.yml
echo -e ":api_password: saltpassword" >> /etc/foreman-proxy/settings.d/salt.yml


service foreman restart && service foreman-proxy restart && service salt-master restart && service salt-api restart && service foreman-tasks restart

foreman-installer --enable-foreman-plugin-salt --enable-foreman-proxy-plugin-salt



service foreman restart && service foreman-proxy restart && service salt-master restart && service salt-api restart && service foreman-tasks restart
