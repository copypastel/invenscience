require File.join( File.dirname(__FILE__), '..', "spec_helper" )
require File.join( File.dirname(__FILE__), '..', "factories", 'base' )
require 'spec/mocks'

SpecFactory.define_valid Warehouse do |w|
  w.set :name, 'Sparkfun', :unique => true
  w.set :parser, Spec::Mocks::Mock.new('parser')
end

describe Warehouse do

  describe "when valid" do
    before(:each) do
      @warehouse = SpecFactory.gen(Warehouse,:saved)
    end
    
    it "should have a unique name" do
      copy = SpecFactory.gen(Warehouse,:valid) do |model|
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
      @warehouse = SpecFactory.gen(Warehouse,:saved)
    end
    
    after(:each) do
      Item.all.each {|w| w.destroy}
    end
    
    it "should have items" do
      @warehouse.should respond_to(:items)
    end
    
    it "should be able to #add items or base_items" do
      item = SpecFactory.gen(Item,:saved)
      @warehouse.add(item).should             be(true)
      @warehouse.items[0].base_item_id.should eql(item.base_item_id)
      @warehouse.items.size.should            be(1)
      @warehouse.items[0].class.should        be(Item)
      #make it so that a different base_item is added then that linking of an item
      dummy,base_item = SpecFactory.gen(BaseItem,:saved,2)
      @warehouse.add(base_item).should        be(true)
      @warehouse.items[1].base_item_id.should eql(base_item.id)
      @warehouse.items.size.should            be(2)
      @warehouse.items[1].class.should        be(Item)
    end
    
    it "should be able to #remove items or base_items" do
      base_item = SpecFactory.gen(BaseItem, :saved)
      @warehouse.add(base_item).should     be(true)
      @warehouse.remove(base_item).should  be(true)
      @warehouse.stocked_items.size.should         be(0)
      
      item = SpecFactory.gen(Item, :saved)
      @warehouse.add(item).should    be(true)
      @warehouse.remove(item).should be(true)
      @warehouse.stocked_items.size.should be(0)
    end
    
    it "should update the item's quantity when adding multiple base items" do
      base_item = SpecFactory.gen(BaseItem, :saved)
      @warehouse.add(base_item).should           be(true)
      @warehouse.add(base_item).should           be(true)
      @warehouse.items.size.should               be(1)
      @warehouse.items[0].base_item_id.should    be(base_item.id)
      @warehouse.items[0].quantity.should        be(2)
    end
    
    it "should update the item's quantity when adding multiple items" do
      item = SpecFactory.gen(Item, :saved)
      @warehouse.add(item).should              be(true)
      @warehouse.add(item).should              be(true)
      @warehouse.items.size.should             be(1)
      @warehouse.items[0].base_item_id.should  be(item.base_item_id)
      @warehouse.items[0].quantity.should      be(2)
    end
    
    it "should return false when adding a bad item" do
      item = SpecFactory.gen(Item, :new)
      @warehouse.add(item).should be(false)
    end
    
    it "should return false when adding a bad base_item" do
      base_item = SpecFactory.gen(BaseItem, :new)
      @warehouse.add(base_item).should be(false)
    end
    
  end
  
  describe "when multiple warehouses exist" do
    before(:each) do
      @warehouse1,@warehouse2 = SpecFactory.gen(Warehouse, :saved, 2)
    end
    
    it "should be able to share items" do
      item = SpecFactory.gen(BaseItem, :saved)
      @warehouse1.add(item)
      @warehouse2.add(item)
      @warehouse1.items[0].base_item_id.should  eql(item.id)
      @warehouse2.items[0].base_item_id.should  eql(item.id)
    end
  end
end