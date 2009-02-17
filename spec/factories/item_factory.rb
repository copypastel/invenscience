require File.join( File.dirname(__FILE__), '..','spec_helper')
require File.join( File.dirname(__FILE__), 'base')

module SpecFactory
  
  class Item < Base
    MODEL_NAME = 'toothbrush'
    
    def initialize
      @new = true
    end
    
    def new_model(count)
      clear_database if @new
      ::Item.new
    end
    
    def valid_model(count)
      clear_database if @new
      ::Item.new(:name => MODEL_NAME + ::Item.count.to_s)
    end
    
    def saved_model(count)
      clear_database if @new
      ::Item.first(:name => MODEL_NAME) || ::Item.create(:name => MODEL_NAME)
    end
    
    private
    
    def clear_database
      @new = false
      ::Item.all.each { |i| i.destroy}
    end
    
  end
    
end