require File.join( File.dirname(__FILE__), 'base')

SpecFactory.define_valid Project do |p|
  p.set :name, 'GPS', :unique => true
end
