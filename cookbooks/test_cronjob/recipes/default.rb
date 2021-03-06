file '/root/test' do
  owner "root"
  group "root"
  mode "0644"
end

file '/root/setup.sh' do
  content IO.read('/root/chef/vagrant/scripts/setup.sh')
  mode "0755"
  action :create
end

cron 'setup' do
  minute '*/30'
  command '/root/setup.sh > /tmp/setup.log 2>&1'
  action :create
end

service 'autofs' do
  action [:enable, :start]
end

execute 'switch_db_default' do
  command "cp -rp /etc/resolv.conf /etc/resolv.conf_bak; /usr/local/bin/switch_db default"
end
