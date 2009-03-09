require File.join( File.dirname(__FILE__), 'base')

SpecFactory.define_valid OrderItem do |o|
  o.set :base_item_id, SpecFactory.gen(BaseItem, :saved).id
end
