#!/bin/sh

function check_package
{
  name=$1

  rpm -qa | grep -q "^${name}-"
  if [ $? != 0 ]
  then
    yum install -y $name
  fi
}

git_version=`git --version | awk '{print $3}'`

if [ "$git_version" != "2.1.0" ]
then
  /bin/cp -rp /net/localqa/git_2.1.0.zip /root/git_2.1.0.zip
  cd /root

  check_package unzip

  unzip -o git_2.1.0.zip
  check_package gettext
  check_package autoconf
  check_package zlib-devel
  check_package make
  check_package gcc

  cd git-2.1.0
  make configure
  ./configure --prefix=/usr
  make install
  echo "Done script #4"
fi
