require File.join( File.dirname(__FILE__), '..', "spec_helper" )
require File.join( File.dirname(__FILE__), '..', 'factories', 'warehouse_factory')
require File.join( File.dirname(__FILE__), '..', 'factories', 'base_item_factory')
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
    
    after(:each) do
      Item.all.each {|w| w.destroy}
    end
    
    it "should have items" do
      @warehouse.should respond_to(:items)
    end
    
    it "should be able to #add items or base_items" do
      item = SpecFactory::Item.gen(:saved)
      @warehouse.add(item).should      be(true)
      @warehouse.items[0].base_item_id.should    eql(item.base_item_id)
      @warehouse.items.size.should     be(1)
      @warehouse.items[0].class.should be(Item)
      
      base_item = SpecFactory::BaseItem.gen(:saved)
      @warehouse.add(base_item).should be(true)
      @warehouse.items[1].base_item_id.should    eql(base_item.id)
      @warehouse.items.size.should     be(2)
      @warehouse.items[1].class.should be(Item)
    end
    
    it "should be able to #remove items or base_items" do
      base_item = SpecFactory::BaseItem.gen(:saved)
      @warehouse.add(base_item).should     be(true)
      @warehouse.remove(base_item).should  be(true)
      @warehouse.stocked_items.size.should be(0)
      
      item = SpecFactory::Item.gen(:saved)
      @warehouse.add(item).should          be(true)
      @warehouse.remove(item).should       be(true)
      @warehouse.stocked_items.size.should be(0)
    end
    
    it "should update the items quantity when adding multiple items" do
      item = SpecFactory::BaseItem.gen(:saved)
      @warehouse.add(item)
      @warehouse.add(item)
      pending
     # @warehouse.items.include?(item).should be(true)
     # @warehouse.items.get(item).quantity.should be(2)
    end
  end
  
  describe "when multiple warehouses exist" do
    before(:each) do
      @warehouse1,@warehouse2 = SpecFactory::Warehouse.gen(:saved,2)
    end
    
    it "should be able to share items" do
      item = SpecFactory::BaseItem.gen(:saved)
      @warehouse1.add(item)
      @warehouse2.add(item)
      @warehouse1.items[0].base_item_id.should    eql(item.id)
      @warehouse2.items[0].base_item_id.should    eql(item.id)
    end
  
  end

end