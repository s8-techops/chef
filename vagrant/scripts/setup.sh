#!/bin/sh

which chef-solo > /dev/null 2>&1

if [ $? -ne 0 ]
then
  cd /root
  wget --no-check-certificate https://packages.chef.io/files/stable/chef/12.3.0/el/5/chef-12.3.0-1.el5.x86_64.rpm
  rpm -ivh chef-12.3.0-1.el5.x86_64.rpm
fi

if [ ! -f /root/.gitconfig ]
then
  cat << EOF > /root/.gitconfig
[http]
    sslVerify = false
EOF
fi

which git > /dev/null 2>&1

if [ $? -ne 0 ]
then
  yum install -y git
fi

if [ ! -d /root/chef ]
then
  cd /root
  git clone https://github.com/s8-techops/chef.git
else
  cd /root/chef
  git pull
fi

chef-solo -c ~/chef/solo.rb
