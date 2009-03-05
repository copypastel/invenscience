require File.join( File.dirname(__FILE__), '..', "spec_helper" )
require File.join( File.dirname(__FILE__), '..', "factories", 'base' )

SpecFactory.define_valid Item do |i|
  i.set :base_item_id, SpecFactory.gen(BaseItem, :saved).id
  #puts SpecFactory.gen(BaseItem, :saved).id
  #puts SpecFactory.gen(BaseItem, :saved).id
end

describe Item do
  describe "when first created" do
    before(:each) do
      @item = SpecFactory.gen(Item, :new)
    end
    
  end
  describe "when valid" do 
    before(:each) do
      @item = SpecFactory.gen(Item, :valid)
    end
    
    it "must have a #base_item" do
      @item.base_item_id = nil
      @item.should_not be_valid
    end
    
  end
  
  describe "when saving" do
    before(:each) do
      @item = SpecFactory.gen(Item, :valid)
    end
    
    it "should set #quantity to 0 if created when nil" do
      @item.quantity = nil
      @item.save.should be(true)
      @item.quantity.should be(0)
    end
    
    it "should not overwrite #quantity if it is set" do
      @item.quantity = 4
      @item.save.should be(true)
      @item.quantity.should be(4)
    end
    
    it "should create a #price_break if saved when price_break is nil" do
      @item.price_break = nil
      @item.save.should be(true)
      @item.price_break.class.should be(PriceBreak)
    end
  end

  describe "when in operation" do
    before(:each) do
      @item = SpecFactory.gen(Item, :saved)
    end
   
    it "should keep track of #quantity" do
      @item.should be_valid
      @item.should respond_to(:quantity)
    end
    
    it "should return the base_items name when #name is called" do
      @item.should be_valid
      @item.name.should eql(@item.base_item.name)
    end
    
    it "should return the #price_for a given quantity" do
      @item.should respond_to(:price_for)
    end
    
  end
end