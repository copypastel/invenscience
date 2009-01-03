require File.join( File.dirname(__FILE__), '..', "spec_helper" )
require File.dirname(__FILE__) + "/../parsers/shared_parser_examples"
require File.join( File.dirname(__FILE__),'factories','warehouse_factory' )
 
#-----------------------------------------#
#           Shared Examples               #
#-----------------------------------------#
shared_examples_for "a new record" do     
  it "should be a new record" do
    @warehouse.should be(:new_record)
  end
end
 
 
#-----------------------------------------#
#            Warehouse Spec               #
#-----------------------------------------#
describe Warehouse do
  describe "when first created" do
    before(:each) do
      @warehouse = Factory::Warehouse[:new]
    end
    
    it "should be a proxy" do
      @warehouse.class.include?(Parser::Proxy).should be(true)
    end
    
    it_should_behave_like "a new record"
  end
  
  describe "when valid" do
    before(:each) do
      @warehouse = Factory::Warehouse[:valid]
    end
    
    it "should have a human readable identifier" do
      @warehouse.should respond_to(:name)
    end
    
    it "should have a unique name" do
      @warehouse.save.should be(true)
      @copy = Factory::Warehouse[:valid]
      
      @copy.should be(:valid)
      @copy.name = @warehouse.name
      @copy.should_not be(:valid)
    end
  end
  
  describe "when in normal operation (saved)" do
    before(:each) do
      @warehouse = Factory::Warehouse[:saved]
    end
    
    it "should have its own inventory" do
      @warehouse.should respond_to(:items)
    end
    
    it "should have a history of all orders made" do
      @warehouse.should respond_to(:orders)
    end
    
    it "should give the #price of an item when given an item with a matching manufacture ID and a quantity" 
    
    it "should give the #price of one item in the warehouse with no quantity given" 
    
  end
end
 
 
=begin
  describe "when newly created" do
    
    before(:each) do
      @warehouse = Factory::Warehouse[:new]
    end
    
#    it_should_have_property(:name)   with(:unique => true)
#    it_should_have_property(:parser) with(:unique => true)
    
    it_should_behave_like "a new record"
    
    it "should not be valid" do
      @warehouse.should_not be(:valid)
    end
    
    it "should have two errors after valid check" do
      @warehouse.should_not be(:valid)
      @warehouse.errors.length.should be(2)
    end
    
    it "should not have default values" do
      @warehouse.name.should    be(nil)
      @warehouse.parser.should  be(nil)
      @warehouse.id.should      be(nil)
    end
  end
  
  describe "when not saved" do
    before(:each) do
      @warehouse = Factory::Warehouse[:valid]
    end
    
    it_should_behave_like "a new record"
    
    it "should not be valid without #name" do
      @warehouse.name = nil
      @warehouse.should_not be(:valid)
    end
    
    it "should not be valid without #parser" do
      @warehouse.parser = nil
      @warehouse.should_not be(:valid)
    end
  end
  
  describe "before save" do
    before(:each) do
      @warehouse = Factory::Warehouse[:valid]
    end
 
    it "should be valid" do
      @warehouse.should be(:valid)
    end
 
    it "should have an original name" do
      @warehouse.name = Factory::Warehouse[:saved].name
      @warehouse.should_not be(:valid)
    end
  end
 
  describe "after save" do
    before(:each) do
      @warehouse = Factory::Warehouse[:new]
    end
    
    it "should not be a new record" do
      @warehouse.should_not be(:valid)
    end
  end
 
=end