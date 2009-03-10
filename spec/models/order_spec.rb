require File.join( File.dirname(__FILE__), '..', "spec_helper" )
require File.join( File.dirname(__FILE__), '..', "factories", 'base' )
require File.join( File.dirname(__FILE__), '..', "shared", 'item_manager_spec' )

describe Order do

  describe "as a item manager" do
     before(:each) do
       @item_manager_class = Order
     end

     it_should_behave_like "an item manager"
   end
   
   describe "when valid" do
     before(:each) do
       @order = SpecFactory.gen(Order,:valid)
     end
     
     it "should must be correltaed to a project" do
       @order.project = nil
       @order.should_not be_valid
     end
   end
end