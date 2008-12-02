# You can integrate this into Warehouse if this is too complicated
# but it provides nice seperation of code
# TODO: Figure out how to move this after warehouse
module ParserManager
  def self.included(warehouse)
    warehouse.before :save, :check_parser
    warehouse.after  :save, :cleanup_parser
    warehouse.extend ClassMethods
  end
  
  @dirty_parser = false
  
  # Setup code for cleanup_parser
  def check_parser()
    @dirty_parser = self.attribute_dirty?(:parser)
  end
  
  # Handles when a parser is changed
  def cleanup_parser() 
    if @dirty_parser and not self.parser.nil?
      # *Need to figure out how to unextend previous parser!
      # *Luckily the method used is the latest module extended 
      extend self.parser
    end
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
  include ::ParserManager
  
  property :id, Serial
  property :name, String, :nullable => false, :unique => true
  property :parser, Object

  has n, :items  
  has n, :details, :through => :items
  has n, :orders, :through => :details
  has n, :carts
    
  # Receive a url for an item.
  # Return an array with all items that were parsed from that url.
  def self.parse(uri)
    Warehouse.all.each {|w| return w.parse(uri) if w.parsable?(uri)}
    nil
  end
  
  def self.price(item, quantity = nil)
    item.warehouse.price( item, quantity )
  end

  # Need a much better name
  def self.place_in_cart(order)
    details = order.details
    order.warehouses.each do |warehouse|
      warehouse.place_in_cart(details.select {|d| d.warehouse == warehouse})
    end
  end

end

