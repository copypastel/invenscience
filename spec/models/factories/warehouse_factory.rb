require File.join( File.dirname(__FILE__),'..','..','spec_helper')
require File.join( File.dirname(__FILE__),'base')
require 'spec/mocks'
#You have to be EXTREEMLY careful with scope... Maybe need to add WarehouseFactory in
module Factory
  
  class Warehouse < Base
    MODEL_NAME = 'Sparkfun'
    MODEL_PARSER = Spec::Mocks::Mock.new('parser')
    
    def initialize
      @new = true
    end
    
    def new_model
      clear_database if @new
      ::Warehouse.new
    end
    
    def valid_model
      clear_database if @new
      ::Warehouse.new(:name => MODEL_NAME + ::Warehouse.count.to_s,:parser => MODEL_PARSER)
    end
    
    def saved_model
      clear_database if @new
      ::Warehouse.first(:name => MODEL_NAME) || ::Warehouse.create(:name => MODEL_NAME, :parser => MODEL_PARSER)
    end
    
    private
    
    def clear_database
      @new = false
      ::Warehouse.all.each { |w| w.destroy}
    end
    
  end
    
end
