require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a base_item exists" do
  BaseItem.all.destroy!
  request(resource(:base_items), :method => "POST", 
    :params => { :base_item => { :id => nil }})
end

describe "resource(:base_items)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:base_items))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of base_items" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a base_item exists" do
    before(:each) do
      @response = request(resource(:base_items))
    end
    
    it "has a list of base_items" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      BaseItem.all.destroy!
      @response = request(resource(:base_items), :method => "POST", 
        :params => { :base_item => { :id => nil }})
    end
    
    it "redirects to resource(:base_items)" do
      @response.should redirect_to(resource(BaseItem.first), :message => {:notice => "base_item was successfully created"})
    end
    
  end
end

describe "resource(@base_item)" do 
  describe "a successful DELETE", :given => "a base_item exists" do
     before(:each) do
       @response = request(resource(BaseItem.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:base_items))
     end

   end
end

describe "resource(:base_items, :new)" do
  before(:each) do
    @response = request(resource(:base_items, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@base_item, :edit)", :given => "a base_item exists" do
  before(:each) do
    @response = request(resource(BaseItem.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@base_item)", :given => "a base_item exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(BaseItem.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @base_item = BaseItem.first
      @response = request(resource(@base_item), :method => "PUT", 
        :params => { :base_item => {:id => @base_item.id} })
    end
  
    it "redirect to the base_item show action" do
      @response.should redirect_to(resource(@base_item))
    end
  end
  
end

