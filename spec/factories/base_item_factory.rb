require File.join( File.dirname(__FILE__), 'base')

SpecFactory.define_valid BaseItem do |b|
  b.set :name, 'Toothbrush', :unique => true
end
