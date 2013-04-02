# recipes/test.rb

# Test basic usage

include_recipe('nginx::default')

nginx_conf_file "test1.mywebsite.com" do
  root "/var/www/myapp"
  socket "/var/www/myapp/shared/tmp/sockets/unicorn.socket"
end

nginx_conf_file "test2.mywebsite.com" do
  root "/var/www/myapp"
end

nginx_conf_file "test3.mywebsite.com" do
  action :disable
end

nginx_conf_file "test4.mywebsite.com" do
  action :delete
end