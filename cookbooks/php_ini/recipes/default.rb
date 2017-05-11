if File.readlines("/etc/php.ini").grep(/error_log = \/var\/log\/httpd\/error\.log/).size > 0
  ruby_block 'update_error_log' do
    block do
      fe = Chef::Util::FileEdit.new('/etc/php.ini')
      fe.search_file_replace_line(/error_log = \/var\/log\/httpd\/error.log/, 'error_log = /var/log/httpd/error_log')
      fe.write_file
    end
    notifies :reload, 'service[httpd]', :immediately
  end
end

service 'httpd' do
  supports :reload => true
end
