remote_file '/usr/bin/phpunit' do
  source 'file:///net/localqa/phpunit'
  owner 'root'
  group 'root'
  mode '0755'
end
