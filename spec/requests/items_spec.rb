require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')
=begin
describe "/items" do
  before(:each) do
    @response = request("/items")
    @name = ['screwdriver', 'multimeter', 'solder'][rand(3)]
  end
  
  it "should respond to :index" do
    @response.should respond_successfully
  end
  
  it "should display an input form at :new" do
    request(resource(:items), :method => :get).should have_xpath("//form[@name='item']")
  end
  
  it "should add an item RESTfully" do
    request(resource(:items), :method => :post, 
      :params => {:name => @name}).should respond_successfully
      
    Item.first(:name => @name).class.should == Item
  end
end
=end