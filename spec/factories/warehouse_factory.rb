require File.join( File.dirname(__FILE__), 'base')
require 'spec/mocks'

SpecFactory.define_valid Warehouse do |w|
  w.set :name, 'Sparkfun', :unique => true
  w.set :parser, Spec::Mocks::Mock.new('parser')
end
