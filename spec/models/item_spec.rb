require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe Item do
  
  before(:each) do
    @item = Item.new
  end

  it "should have a name" do
    @item.name = 'gps logger'
    @item.name.should == 'gps logger'
  end
  
  it "should not be valid unless it has a name" do
    @item.valid?.should == false
  end
  
  it "should save if valid" do
    @item.name = 'gps logger'
    @item.valid?.should == true
    @item.save.should == true
  end

end