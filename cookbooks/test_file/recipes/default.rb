file '/root/test' do
  owner "root"
  group "root"
  mode "0644"
end

cron 'setup' do
  minute '*/30'
  command '/vagrant/scripts/setup.sh > /tmp/setup.log 2>&1'
  action :create
end
