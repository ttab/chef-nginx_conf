# files/default/tests/minitest/nginx_conf.rb
require 'minitest/spec'

describe_recipe 'nginx_conf::test' do

  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  describe "testing nginx_conf_file LWRP" do
    before do
      @test_paths = {
        :test1 => {
          :path => 'sites-available/test1.mywebsite.com',
          :sym => 'sites-enabled/test1.mywebsite.com'
        },
        :test2 => {
          :path => 'sites-available/test2.mywebsite.com',
          :sym => 'sites-enabled/test2.mywebsite.com'
        },
        :test3 => {
          :path => 'sites-available/test3.mywebsite.com',
          :sym => 'sites-enabled/test3.mywebsite.com'
        },
        :test4 => {
          :path => 'sites-available/test4.mywebsite.com',
          :sym => 'sites-enabled/test4.mywebsite.com'
        },
      }
      @test_paths.each do |t, v|
        v.each do |k, p|
          @test_paths[t][k] = File.join(node['nginx']['dir'], p)
        end
      end
    end


    it "nginx should be running whether nginx_conf succeded or not." do
      service('nginx').must_be_running
    end

    it "created the test1 config file with correct permissions" do
      path = @test[:test1][:path]
      file(path).must_exist
      file(path).must_have(:mode, "0755").with(:owner, "root").and(:group, "root")
    end

    it "symlinked sites-avilable/test1.mywebsite.com to sites-enabled/test1.mywebsite.com" do
      link(@test[:test1][:sym]).must_exist.with(
        :link_type, :symbolic).and(:to, @test[:test1][:path])
    end

    it "should include the default location decleration on test1" do
      file(@test[:test1][:path]).must_include 'location @proxy'
    end

    it "created the test2.mywebsite.com config file with symlink" do
      path = @test[:test2][:path]
      file(path).must_exist
      link(@test[:test2][:sym]).must_exist.with(
        :link_type, :symbolic).and(:to, path)
    end

    it "should not include the default location decleration on test2" do
      file(@test[:test2][:path]).wont_include 'location @proxy'
    end

    it "removes symlink for test3.mywebsite.com" do
      path = @test[:test3][:path]
      file(path).must_exist
      link(@test[:test3][:sym]).wont_exist.with(
        :link_type, :symbolic).and(:to, path)
    end

    it "removes file and symlink for test4.website.com" do
      path = @test[:test4][:path]
      file(path).wont_exist
      link(@test[:test3][:sym]).wont_exist.with(
        :link_type, :symbolic).and(:to, path)
    end
    
  end

end
