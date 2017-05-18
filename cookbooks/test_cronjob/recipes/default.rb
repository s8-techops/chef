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

file '/etc/resolv.conf_bak' do
  content IO.read('/etc/resolv.conf')
  action :create
end

execute 'switch_db_default' do
  command '/usr/local/bin/switch_db default'
end
