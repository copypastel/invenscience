require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a cart exists" do
  Cart.all.destroy!
  request(resource(:carts), :method => "POST", 
    :params => { :cart => { :id => nil }})
end

describe "resource(:carts)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:carts))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of carts" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a cart exists" do
    before(:each) do
      @response = request(resource(:carts))
    end
    
    it "has a list of carts" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Cart.all.destroy!
      @response = request(resource(:carts), :method => "POST", 
        :params => { :cart => { :id => nil }})
    end
    
    it "redirects to resource(:carts)" do
      @response.should redirect_to(resource(Cart.first), :message => {:notice => "cart was successfully created"})
    end
    
  end
end

describe "resource(@cart)" do 
  describe "a successful DELETE", :given => "a cart exists" do
     before(:each) do
       @response = request(resource(Cart.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:carts))
     end

   end
end

describe "resource(:carts, :new)" do
  before(:each) do
    @response = request(resource(:carts, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@cart, :edit)", :given => "a cart exists" do
  before(:each) do
    @response = request(resource(Cart.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@cart)", :given => "a cart exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Cart.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @cart = Cart.first
      @response = request(resource(@cart), :method => "PUT", 
        :params => { :cart => {:id => @cart.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@cart))
    end
  end
  
end

