require File.join( File.dirname(__FILE__), 'base')

module SpecFactory
  
  class PriceBreak < Base
        
    def initialize
      @new = true
    end
    
    def new_model(count)
      clear_database if @new
      ::PriceBreak.new
    end
    
    def valid_model(count)
      clear_database if @new
      ::PriceBreak.new
    end
    
    def saved_model(count)
      clear_database if @new
      ::PriceBreak.first() || ::PriceBreak.create()
    end
    
    private
    
    def clear_database
      @new = false
      ::PriceBreak.all.each { |p| p.destroy}
    end
    
  end
    
end