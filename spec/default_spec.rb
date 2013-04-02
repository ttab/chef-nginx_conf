require 'chefspec'

describe "nginx_conf::default" do
	let(:chef_run) { 
		runner = ChefSpec::ChefRunner.new do |node|
			node['nginx_conf'] = {
				'confs' => {
					'test_site' => {
						'socket' => '/tmp/test_site.socket'
					},
					'test_site1' => {
						'socket' => '/tmp/test_site1.socket'
					}
				}
			}
			node['nginx'] = {
				'user' => 'nginx',
				'group' => 'nginx',
				'dir' => '/etc/nginx'
			}
		end
		runner.converge 'nginx_conf::default'
	}
	it "runs nginx_conf_file for the nginx_conf attribute array" do
		chef_run.node[:nginx_conf][:confs].each do |app_name, conf|
			expect(chef_run).to create_file "#{chef_run.node[:dir]}/sites-available/#{app_name}"
		end
	end
end