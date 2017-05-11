execute 'switch_db_default' do
  command '/usr/local/bin/switch_db default'
end

package 'stunnel' do
  action :purge
end

package 'stunnel-s8-5.noarch' do
  action :install
end

remote_file '/etc/httpd/ssl/me.corp.storm8.com.crt' do
  source 'file:///net/localqa/storm8_cert/me.corp.storm8.com.crt'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :restart, 'service[httpd]', :immediately
end

remote_file '/etc/httpd/ssl/gd_bundle.crt' do
  source 'file:///net/localqa/storm8_cert/gd_bundle.crt'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :restart, 'service[httpd]', :immediately
end

remote_file '/etc/httpd/ssl/storm8.com.key' do
  source 'file:///net/localqa/storm8_cert/storm8.com.key'
  owner 'root'
  group 'root'
  mode '0400'
  action :create
  notifies :restart, 'service[httpd]', :immediately
end

remote_file '/etc/stunnel/httpd_storm8.com' do
  source 'file:///net/localqa/storm8_cert/httpd_storm8.com'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :restart, 'service[stunnel]', :immediately
end

service 'stunnel' do
  supports :restart => true
  action [:enable, :start]
end

service 'httpd' do
  supports :restart => true
  action [:enable, :start]
end
