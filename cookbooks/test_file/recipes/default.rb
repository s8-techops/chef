file '/root/test' do
  owner "root"
  group "root"
  mode "0644"
end

cron 'setup' do
  minute '*/30'
  command '/root/setup.sh > /tmp/setup.log'
  action :create
end
