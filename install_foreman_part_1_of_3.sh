#!/usr/bin/env bash
wget http://public-yum.oracle.com/public-yum-ol6.repo -P /etc/yum.repos.d/
## RHEL/CentOS 6 64-Bit ##
wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh epel-release-6-8.noarch.rpm
# 1. Install a package with repository for your system:
# On CentOS, install package centos-release-scl available in CentOS repository:
sudo yum install centos-release-scl
# On RHEL, enable RHSCL repository for you system:
sudo yum-config-manager --enable rhel-server-rhscl-6-rpms
yum -y install https://www.softwarecollections.org/en/scls/rhscl/v8314/epel-6-x86_64/download/rhscl-v8314-epel-6-x86_64.noarch.rpm
# 2. Install the collection:
sudo yum -y install v8314
# 3. Start using the software collection:
scl enable v8314 bash
