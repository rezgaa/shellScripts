

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




# 1. Install the Software Collections tools:
yum install scl-utils

# 2. Download a package with repository for your system.
#  (See the Yum Repositories section below. You can use `wget URL`.)
yum install https://www.softwarecollections.org/en/scls/rhscl/ruby193/epel-6-x86_64/download/rhscl-ruby193-epel-6-x86_64.noarch.rpm
# 3. Install the repo package:
yum install rhscl-ruby193-*.noarch.rpm

# 4. Install the collection:
yum -y install ruby193
yum -y install ruby193-ruby-devel.x86_64 

# 5. Start using software collections:
scl enable ruby193 bash


rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
yum -y install epel-release http://yum.theforeman.org/releases/1.10/el6/x86_64/foreman-release.rpm
yum -y install foreman-installer

gem install kafo
gem install ansi -v 1.4.3
gem install mongrel --pre


###############################################################3
################################################################3



gem install kafo mongrel ansi 


check the installed gems

# gem list



yum -y install vim bash-completion

yum -y install postgresql-server postgresql-contrib

service postgressql initdb

service posotgresql start

yum install -y "Developer Tools"








# Install RVM 
command curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
\curl -sSL https://get.rvm.io | bash -s stable --ruby
rvm install 1.9.3
rvm use 2.1
