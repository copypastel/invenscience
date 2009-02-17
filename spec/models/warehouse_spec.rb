require File.join( File.dirname(__FILE__), '..', "spec_helper" )
require File.join( File.dirname(__FILE__), '..', 'factories', 'warehouse_factory')
require File.join( File.dirname(__FILE__), '..', 'factories', 'item_factory')

describe Warehouse do

  describe "when valid" do
    before(:each) do
      @warehouse = SpecFactory::Warehouse.gen(:saved)
    end
    
    it "should have a unique name" do
      copy = SpecFactory::Warehouse.gen(:valid) do |model| 
        model.name = @warehouse.name 
      end
      
      copy.should_not be_valid
    end
    
    it "should have a parser" do
      @warehouse.parser = nil
      @warehouse.should_not be_valid
    end
  end
  
  describe "when in operation" do
    before(:each) do
      @warehouse = SpecFactory::Warehouse.gen(:saved)
    end
    
    it "should have items" do
      @warehouse.should respond_to(:items)
    end
    
    it "should be able to #add new items" do
      item = SpecFactory::Item.gen(:saved)
      @warehouse.add(item)
      @warehouse.items.include?(item).should be(true)
    end
    
    it "should be able to #remove items" do
      item = SpecFactory::Item.gen(:saved)
      @warehouse.add(item)
      @warehouse.remove(item)
      
      @warehouse.items.include?(item).should be(false)
    end
  end
  
  describe "when multiple warehouses exist" do
    before(:each) do
      @warehouse1,@warehouse2 = SpecFactory::Warehouse.gen(:saved,2)
    end
    
    it "should be able to share items" do
      item = SpecFactory::Item.gen(:saved)
      @warehouse1.add(item)
      @warehouse2.add(item)
      
      @warehouse1.items.include?(item).should be(true)
      @warehouse2.items.include?(item).should be(true)
    end
  
  end

end