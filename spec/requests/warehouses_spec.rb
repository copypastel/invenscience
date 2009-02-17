require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')
require File.join(File.dirname(__FILE__), '..', 'factories', 'warehouse_factory')

given "a warehouse exists" do
  Warehouse.all.destroy!
  warehouse = SpecFactory::Warehouse.gen(:valid)
  request(resource(:warehouses), :method => "POST", 
    :params => { :warehouse => warehouse.attributes })
end

describe "resource(:warehouses)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:warehouses))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of warehouses" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a warehouse exists" do
    before(:each) do
      @response = request(resource(:warehouses))
    end
    
    it "has a list of warehouses" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Warehouse.all.destroy!
      warehouse = SpecFactory::Warehouse.gen(:valid)
      @response = request(resource(:warehouses), :method => "POST", 
        :params => { :warehouse =>  warehouse.attributes })
    end
    
    it "redirects to resource(:warehouses)" do
      @response.should redirect_to(resource(Warehouse.first), :message => {:notice => "warehouse was successfully created"})
    end
    
  end
end

describe "resource(@warehouse)" do 
  describe "a successful DELETE", :given => "a warehouse exists" do
     before(:each) do
       @response = request(resource(Warehouse.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:warehouses))
     end

   end
end

describe "resource(:warehouses, :new)" do
  before(:each) do
    @response = request(resource(:warehouses, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@warehouse, :edit)", :given => "a warehouse exists" do
  before(:each) do
    @response = request(resource(Warehouse.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@warehouse)", :given => "a warehouse exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Warehouse.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @warehouse = Warehouse.first
      @response = request(resource(@warehouse), :method => "PUT", 
        :params => { :warehouse => {:id => @warehouse.id} })
    end
  
    it "redirect to the warehouse show action" do
      @response.should redirect_to(resource(@warehouse))
    end
  end
  
end

