require File.join( File.dirname(__FILE__), '..', "spec_helper" )
require File.join( File.dirname(__FILE__), '..', 'factories', 'item_factory')

describe Item do
  describe "when first created" do
    before(:each) do
      @item = SpecFactory::Item.gen(:new)
    end
    
  end
  describe "when valid" do 
    before(:each) do
      @item = SpecFactory::Item.gen(:valid)
    end
    
    it "must have a #base_item" do
      @item.base_item_id = nil
      @item.should_not be_valid
    end
  end
  
  describe "when saving" do
    before(:each) do
      @item = SpecFactory::Item.gen(:valid)
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
  end

  describe "when in operation" do
    before(:each) do
      @item = SpecFactory::Item.gen(:saved)
    end
   
    it "should keep track of #quantity" do
      @item.should respond_to(:quantity)
    end
    
    it "should return the base_items name wehn #name is called" do
      @item.name.should eql(@item.base_item.name)
    end
    
  end
end