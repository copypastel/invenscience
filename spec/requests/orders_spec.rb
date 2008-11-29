require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a order exists" do
  Order.all.destroy!
  request(resource(:orders), :method => "POST", 
    :params => { :order => { :id => nil }})
end

describe "resource(:orders)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:orders))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of orders" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a order exists" do
    before(:each) do
      @response = request(resource(:orders))
    end
    
    it "has a list of orders" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Order.all.destroy!
      @response = request(resource(:orders), :method => "POST", 
        :params => { :order => { :id => nil }})
    end
    
    it "redirects to resource(:orders)" do
      @response.should redirect_to(resource(Order.first), :message => {:notice => "order was successfully created"})
    end
    
  end
end

describe "resource(@order)" do 
  describe "a successful DELETE", :given => "a order exists" do
     before(:each) do
       @response = request(resource(Order.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:orders))
     end

   end
end

describe "resource(:orders, :new)" do
  before(:each) do
    @response = request(resource(:orders, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@order, :edit)", :given => "a order exists" do
  before(:each) do
    @response = request(resource(Order.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@order)", :given => "a order exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Order.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @order = Order.first
      @response = request(resource(@order), :method => "PUT", 
        :params => { :order => {:id => @order.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@order))
    end
  end
  
end

