require File.join( File.dirname(__FILE__), '..', "spec_helper" )
require File.dirname(__FILE__) + "/../parsers/shared_parser_examples"
require File.join( File.dirname(__FILE__),'factories','warehouse_factory' )
 
#-----------------------------------------#
#           Shared Examples               #
#-----------------------------------------#
shared_examples_for "a new record" do     
  it "should be a new record" do
    @warehouse.should be_new_record
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
  
  describe "should be a proxy and" do
    before(:all) do
      @parser = Factory::Warehouse[:new]
    end
    
    it_should_behave_like "a parser with required methods"
  end
  
  
   # it "should be able to parse its website"# do
 #     @parser = @warehouse
      
  #  end
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