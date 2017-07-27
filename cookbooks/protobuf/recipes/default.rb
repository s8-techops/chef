remote_file '/usr/lib/php/extensions/no-debug-non-zts-20121212/protobuf.so' do
  source 'file:///net/localqa/protobuf.so'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :restart, 'service[httpd]', :immediately
end

service 'httpd' do
  supports :restart => true
end
