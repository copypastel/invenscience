require File.join( File.dirname(__FILE__), '..', "spec_helper" )
require File.join( File.dirname(__FILE__), '..', "factories", 'base' )
require File.join( File.dirname(__FILE__), '..', "shared", 'item_manager_spec' )

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
  end  
  
  describe "as a item manager" do
    before(:each) do
      @item_manager_class = Warehouse
    end
    
    it_should_behave_like "an item manager"
  end
end