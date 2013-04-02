# test/kitchen/cookbooks/recipes/nginx_conf_test/test.rb

nginx_conf_file "test3.mywebsite.com" do
  root "/var/www/myapp"
end

nginx_conf_file "test4.mywebsite.com" do
  root "/var/www/myapp"
end