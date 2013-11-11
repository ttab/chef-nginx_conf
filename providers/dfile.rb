action :create do
  conf_name = new_resource.conf_name || new_resource.name
  template "#{node[:nginx][:dir]}/conf.d/#{conf_name}" do
    owner node[:nginx][:user] 
    group node[:nginx][:group]
    mode '755'
    source 'confd.erb'
    variables(
      :block =>  new_resource.block
    )
    notifies :restart, 'service[nginx]', new_resource.reload
  end
end
action :delete do
  conf_name = new_resource.conf_name || new_resource.name

  file "#{node[:nginx][:dir]}/conf.d/#{conf_name}" do
    action :delete
    notifies :restart, 'service[nginx]', new_resource.reload
  end
end
