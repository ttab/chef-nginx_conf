actions :create, :delete

default_action :create

attribute :block, :kind_of => [String, Array, NilClass], :default => nil # Include additional code
attribute :reload, :kind_of => [Symbol], :equal_to => [:delayed, :immediately], :default => :delayed # How soon should we restart nginx.
attribute :conf_name, :kind_of => [String, NilClass], :default => nil # Configuration name.

def initialize(*args)
  super
  @action = :create
end
