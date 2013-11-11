actions :create, :delete

default_action :create

attribute :block, :kind_of => [String, Array, NilClass], :default => nil # Include additional code

def initialize(*args)
  super
  @action = :create
end
