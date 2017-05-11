Dir.glob("/net/conf/vhosts/*.conf").each do |f|
  name = File.basename(f)
  link "/etc/httpd/conf/vhosts/#{name}" do
    to "#{f}"
  end
end
