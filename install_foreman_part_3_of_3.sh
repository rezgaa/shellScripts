rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
yum -y install epel-release http://yum.theforeman.org/releases/1.10/el6/x86_64/foreman-release.rpm
yum -y install foreman-installer

gem install kafo
gem install ansi -v 1.4.3
gem install mongrel --pre

yum -y install vim bash-completion

yum -y install postgresql-server postgresql-contrib

service postgresql initdb

service posotgresql start

foreman-installer
