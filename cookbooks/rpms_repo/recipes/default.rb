Dir.glob("/etc/yum.repos.d/*.repo").each do |f|
  if not File.readlines("#{f}").grep(/rpms.sv4/).size > 0
    ruby_block 'update_rpms_repo' do
      block do
        fe = Chef::Util::FileEdit.new("#{f}")
        fe.search_file_replace(/rpms/, 'rpms.sv4.prod.storm8.com')
        fe.write_file
      end
    end
  end
end
