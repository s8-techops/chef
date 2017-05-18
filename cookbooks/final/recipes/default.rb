file '/etc/resolv.conf' do
  content IO.read('/etc/resolv.conf_bak')
  action :create
end

file '/etc/resolv.conf_bak' do
  action :delete
end
