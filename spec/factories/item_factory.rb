require File.join( File.dirname(__FILE__), '..','spec_helper')
require File.join( File.dirname(__FILE__), 'base_item_factory')

module SpecFactory
  
  class Item < Base
    
    def initialize
      @new = true
    end
    
    def new_model(count)
      clear_database if @new
      ::Item.new
    end
    
    def valid_model(count)
      clear_database if @new
      ::Item.new(:base_item_id => SpecFactory::BaseItem.gen(:saved).id)
    end
    
    def saved_model(count)
      clear_database if @new
      ::Item.first || ::Item.create(:base_item_id => SpecFactory::BaseItem.gen(:saved).id)
    end
    
    private
    
    def clear_database
      @new = false
      ::Item.all.each { |i| i.destroy}
    end
    
  end
    
end