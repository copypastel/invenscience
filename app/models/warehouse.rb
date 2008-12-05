# You can integrate this into Warehouse if this is too complicated
# but it provides nice seperation of code
# TODO: Figure out how to move this after warehouse
module ParserManager
  def self.included(warehouse)
    warehouse.extend ClassMethods
  end
  
  def attribute_set(name, value)
    result = super(name,value)
    if name == :parser and attribute_dirty?(:parser) 
      # *Need to figure out how to unextend previous parser!
      # *Luckily the method used is the latest module extended 
      extend self.parser if not self.parser.nil?
    end
    result
  end
  
  module ClassMethods
    # Handles when an object is retrieved from the database
    def load(values, query)
      warehouse = super(values,query)
      warehouse.extend warehouse.parser unless warehouse.parser.nil?
      warehouse
    end        
  end
  
end

class Warehouse  
  include DataMapper::Resource
  include ParserManager
  
  property :id, Serial
  property :name, String, :nullable => false, :unique => true
  property :parser, Object, :nullable => false

  has n, :items  
  has n, :details, :through => :items
  has n, :orders, :through => :details
  has n, :carts
  
  #Class Methods.  Instance methods inherited from parser
  class << self
    # Receive a url for an item. 
    # Return an array with all items that were parsed from that url.
    def parse(uri)
      Warehouse.all.each {|w| return w.parse(uri) if w.parsable?(uri)}
      nil
    end
  
    def price(item, quantity = nil)
      item.warehouse.price( item, quantity )
    end

    # Need a much better name
    def place_in_cart(order)
      details = order.details
      order.warehouses.each do |warehouse|
        warehouse.place_in_cart(details.select {|d| d.warehouse == warehouse})
      end
    end
  end
  
end

