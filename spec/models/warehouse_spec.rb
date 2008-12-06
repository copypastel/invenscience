require File.join( File.dirname(__FILE__), '..', "spec_helper" )
require File.join( File.dirname(__FILE__), 'factories', 'warehouse_factory' )

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
    
  describe "when newly created" do
    before(:each) do
      @warehouse = Factory::Warehouse[:new]
    end
    
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
  
end
