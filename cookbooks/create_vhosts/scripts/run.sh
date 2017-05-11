remote_vhost_path="/net/conf/vhosts"
local_vhost_path="/etc/httpd/conf/vhosts"

cd ${remote_vhost_path}

if [ $? -ne 0 ]
then
  echo "Something wrong on script2, please check it manually"
  exit
fi

for line in `ls ${remote_vhost_path}/`
do
  cd ${local_vhost_path}

  if [ ! -f $line ]
  then
    ln -s ${remote_vhost_path}/${line} .
  fi
done

echo "Done script #2"
