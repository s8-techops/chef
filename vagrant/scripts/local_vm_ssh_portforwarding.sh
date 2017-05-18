#!/bin/sh

#Setup ssh key
if [ ! -f ~/.ssh/localqa ]
then
  ssh-keygen -t rsa -f ~/.ssh/localqa -N ''
fi
  
cat ~/.ssh/localqa.pub | ssh root@local-qa.corp.storm8.com "cat >> ~/.ssh/authorized_keys"

grep -q local-qa ~/.ssh/config 2> /dev/null

if [ $? -ne 0 ]
then
  cat << 'SSHEOF' >> ~/.ssh/config
Host local-qa*
  Hostname local-qa.corp.storm8.com
  IdentityFile ~/.ssh/localqa
SSHEOF
fi

#cleanup all exisitng ssh port forwarding
pgrep -f 'ssh -f -N -L' | sudo xargs kill -9

echo "sudo ssh -f -N -L 80:local-qa.corp.storm8.com:80 -i ~/.ssh/localqa local-qa.corp.storm8.com"
sudo ssh -f -N -L 80:local-qa.corp.storm8.com:80 -i ~/.ssh/localqa local-qa.corp.storm8.com

echo "sudo ssh -f -N -L 8888:local-qa.corp.storm8.com:80 -i ~/.ssh/localqa local-qa.corp.storm8.com"
sudo ssh -f -N -L 8888:local-qa.corp.storm8.com:80 -i ~/.ssh/localqa local-qa.corp.storm8.com

echo "sudo ssh -f -N -L 443:local-qa.corp.storm8.com:443 -i ~/.ssh/localqa local-qa.corp.storm8.com"
sudo ssh -f -N -L 443:local-qa.corp.storm8.com:443 -i ~/.ssh/localqa local-qa.corp.storm8.com

echo "sudo ssh -f -N -L 3306:local-qa.corp.storm8.com:3306 -i ~/.ssh/localqa local-qa.corp.storm8.com"
sudo ssh -f -N -L 3306:local-qa.corp.storm8.com:3306 -i ~/.ssh/localqa local-qa.corp.storm8.com

for i in `seq 0 4`
do
  interface=`ifconfig en${i} 2> /dev/null | grep -v inet6 | grep inet`
  if [ $? -eq 0 ]
  then
    ip=`echo $interface | awk '{print $2}'`
    echo "sudo ssh -f -N -L ${ip}:80:local-qa.corp.storm8.com:80 -i ~/.ssh/localqa local-qa.corp.storm8.com"
    sudo ssh -f -N -L ${ip}:80:local-qa.corp.storm8.com:80 -i ~/.ssh/localqa local-qa.corp.storm8.com

    echo "sudo ssh -f -N -L ${ip}:8888:local-qa.corp.storm8.com:80 -i ~/.ssh/localqa local-qa.corp.storm8.com"
    sudo ssh -f -N -L ${ip}:8888:local-qa.corp.storm8.com:80 -i ~/.ssh/localqa local-qa.corp.storm8.com

    echo "sudo ssh -f -N -L ${ip}:443:local-qa.corp.storm8.com:443 -i ~/.ssh/localqa local-qa.corp.storm8.com"
    sudo ssh -f -N -L ${ip}:443:local-qa.corp.storm8.com:443 -i ~/.ssh/localqa local-qa.corp.storm8.com

    echo "sudo ssh -f -N -L ${ip}:3306:local-qa.corp.storm8.com:3306 -i ~/.ssh/localqa local-qa.corp.storm8.com"
    sudo ssh -f -N -L ${ip}:3306:local-qa.corp.storm8.com:3306 -i ~/.ssh/localqa local-qa.corp.storm8.com
  fi
done 
