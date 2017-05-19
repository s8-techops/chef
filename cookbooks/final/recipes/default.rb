execute 'restore /etc/resolv.conf' do
  command "cp -rp /etc/resolv.conf_bak /etc/resolv.conf"
end

file '/etc/resolv.conf_bak' do
  action :delete
end
