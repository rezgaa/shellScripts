
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
