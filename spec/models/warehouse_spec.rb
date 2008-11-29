require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe Warehouse do

  before(:each) do
    @warehouse = Warehouse.new
  end

  it "should have a name" do
    @warehouse.name = 'Sparkfun'
    @warehouse.name.should == 'Sparkfun'
  end

  it "should not be valid unless it has a name" do
    @warehouse.valid?.should == false
  end
  
  it "should save if valid" do
    @warehouse.name = 'Sparkfun'
    @warehouse.valid?.should == true
    @warehouse.save.should == true
  end

end