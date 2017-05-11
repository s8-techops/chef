if File.readlines("/etc/scribe/scribe.conf").grep(/port=1464/).size > 0
  ruby_block 'update_scribe_port' do
    block do
      fe = Chef::Util::FileEdit.new('/etc/scribe/scribe.conf')
      fe.search_file_replace_line(/port=1464/, 'port=1463')
      fe.write_file
    end
    notifies :restart, 'service[scribe]', :immediately
  end
end

service 'scribe' do
  supports :restart => true
end
