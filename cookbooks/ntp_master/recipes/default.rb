remote_file '/etc/cron.d/ntp_master_sync' do
  source 'file:///net/localqa/cron.d/ntp_master_sync'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, 'service[crond]', :immediately
end

service 'crond' do
  supports :reload => true
end
