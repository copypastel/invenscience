require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe Supplier do

  before(:each) do
    @supplier = Supplier.new
  end

  it "should have a name" do
    @supplier.name = 'Sparkfun'
    @supplier.name.should == 'Sparkfun'
  end

  it "should not be valid unless it has a name" do
    @supplier.valid?.should == false
  end
  
  it "should save if valid" do
    @supplier.name = 'Sparkfun'
    @supplier.valid?.should == true
    @supplier.save.should == true
  end

end