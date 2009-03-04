require File.join( File.dirname(__FILE__), 'base')

module SpecFactory
  
  class BaseItem < Base
    MODEL_NAME = 'toothbrush'
    
    def initialize
      @new = true
    end
    
    def new_model(count)
      clear_database if @new
      ::BaseItem.new
    end
    
    def valid_model(count)
      clear_database if @new
      ::BaseItem.new(:name => MODEL_NAME + ::BaseItem.count.to_s)
    end
    
    def saved_model(count)
      clear_database if @new
      ::BaseItem.first(:name => MODEL_NAME + ::BaseItem.count.to_s) || ::BaseItem.create(:name => MODEL_NAME + ::BaseItem.count.to_s)
    end
    
    private
    
    def clear_database
      @new = false
      ::BaseItem.all.each { |b| b.destroy}
    end
    
  end
    
end