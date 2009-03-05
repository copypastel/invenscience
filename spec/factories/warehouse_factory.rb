require File.join( File.dirname(__FILE__), 'base')
require 'spec/mocks'

#You have to be EXTREEMLY careful with scope... Maybe need to add WarehouseFactory in
module SpecFactory
  
  class Warehouse < Base
    MODEL_NAME = 'Sparkfun'
    MODEL_PARSER = Spec::Mocks::Mock.new('parser')
    
    def initialize
      @new = true
    end
    
    def new_model(count)
      clear_database if @new
      if count == 1
        ::Warehouse.new
      else
        array = []
        count.times {array.push(::Warehouse.new)}
        array
      end
    end
    
    def valid_model(count)
      clear_database if @new
      if count == 1
        ::Warehouse.new(:name => MODEL_NAME + ::Warehouse.count.to_s,:parser => MODEL_PARSER)
      else
        array = []
        count.times {|i| array.push(::Warehouse.new(:name => MODEL_NAME + (::Warehouse.count+i).to_s,:parser => MODEL_PARSER))}
        array
      end
    end
    
    def saved_model(count)
      clear_database if @new
      if count == 1
        ::Warehouse.first || ::Warehouse.create(:name => MODEL_NAME, :parser => MODEL_PARSER)
      else
        array = []
        count.times { |i| array.push(::Warehouse.get(i) || ::Warehouse.create(:name => MODEL_NAME + (::Warehouse.count+i).to_s, :parser => MODEL_PARSER))}
        array
      end
    end
    
    private
    
    def clear_database
      @new = false
      ::Warehouse.all.each { |w| w.destroy}
    end
    
  end
    
end

describe SpecFactory::Warehouse do
  it "should #gen one new model when no count is given" do
    warehouse = SpecFactory::Warehouse.gen(:new)
    warehouse.should be_new_record
  end
  
  it "should #gen multiple new models when a count is given" do
    warehouse1, warehouse2 = SpecFactory::Warehouse.gen(:new,2)
    warehouse1.should be_new_record
    warehouse2.should be_new_record
  end
  
  it "should #gen one valid model when no count is given" do
    warehouse = SpecFactory::Warehouse.gen(:valid)
    warehouse.should be_valid
  end
  
  it "should #gen multiple new models when a count is given" do
    warehouse1, warehouse2 = SpecFactory::Warehouse.gen(:valid,2)
    warehouse1.should be_valid
    warehouse2.should be_valid
  end
  
  it "should #gen one saved model when no count is given" do
    warehouse = SpecFactory::Warehouse.gen(:saved)
    warehouse.should be_valid
    warehouse.should_not be_new_record
  end
  
  it "should #gen the same saved model each time" do
    warehouse1 = SpecFactory::Warehouse.gen(:saved)
    warehouse2 = SpecFactory::Warehouse.gen(:saved)
    
    warehouse1.id.should eql(warehouse2.id) 
  end
end