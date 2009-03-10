describe "an item manager", :shared => true do
  describe "in normal operation" do
    before(:each) do
      @item_manager = SpecFactory.gen(@item_manager_class, :saved)
    end
    
    after(:each) do
      @item_manager.item_class_hook.all.each {|w| w.destroy}
    end
    
    it "should be able to #add items or base_items" do
      item = SpecFactory.gen(Item,:saved)
      @item_manager.add(item).should             be(true)
      @item_manager.item_hook[0].base_item_id.should eql(item.base_item_id)
      @item_manager.item_hook.size.should            be(1)
      @item_manager.item_hook[0].class.should        be(@item_manager.item_class_hook)
      #make it so that a different base_item is added then that linking of an item
      dummy,base_item = SpecFactory.gen(BaseItem,:saved,2)
      @item_manager.add(base_item).should        be(true)
      @item_manager.item_hook[1].base_item_id.should eql(base_item.id)
      @item_manager.item_hook.size.should            be(2)
      @item_manager.item_hook[1].class.should        be(@item_manager.item_class_hook)
    end
    
    it "should be able to #remove items or base_items" do
      base_item = SpecFactory.gen(BaseItem, :saved)
      @item_manager.add(base_item).should     be(true)
      @item_manager.remove(base_item).should  be(true)
      @item_manager.item_hook[0].quantity.should  be(0)
      
      item = SpecFactory.gen(Item, :saved)
      @item_manager.add(item).should    be(true)
      @item_manager.remove(item).should be(true)
      @item_manager.item_hook[0].quantity.should be(0)
    end
    
    it "should update the item's quantity when adding multiple base items" do
      base_item = SpecFactory.gen(BaseItem, :saved)
      @item_manager.add(base_item).should           be(true)
      @item_manager.add(base_item).should           be(true)
      @item_manager.item_hook.size.should               be(1)
      @item_manager.item_hook[0].base_item_id.should    be(base_item.id)
      @item_manager.item_hook[0].quantity.should        be(2)
    end
    
    it "should update the item's quantity when adding multiple items" do
      item = SpecFactory.gen(Item, :saved)
      @item_manager.add(item).should              be(true)
      @item_manager.add(item).should              be(true)
      @item_manager.item_hook.size.should             be(1)
      @item_manager.item_hook[0].base_item_id.should  be(item.base_item_id)
      @item_manager.item_hook[0].quantity.should      be(2)
    end
    
    it "should return false when adding a bad item" do
      item = SpecFactory.gen(Item, :new)
      @item_manager.add(item).should be(false)
    end
    
    it "should return false when adding a bad base_item" do
      base_item = SpecFactory.gen(BaseItem, :new)
      @item_manager.add(base_item).should be(false)
    end
  
    it "should be able to add multiple items at a time" do
      base_item = SpecFactory.gen(BaseItem,:saved)
      @item_manager.add(base_item,10).should be(true)
      @item_manager.item_hook.size.should be(1)
      @item_manager.item_hook[0].quantity.should be(10)
    end
    
    it "should be able to remove multiple items at a time" do
      base_item = SpecFactory.gen(BaseItem,:saved)
      @item_manager.add(base_item,10).should be(true)
      @item_manager.item_hook.size.should be(1)
      @item_manager.item_hook[0].quantity.should be(10)
      @item_manager.remove(base_item,5).should be(true)
      @item_manager.item_hook[0].quantity.should be(5)
    end
  end
  
  describe "when multiple item_managers exist" do
    before(:each) do
      @item_manager1,@item_manager2 = SpecFactory.gen(@item_manager_class, :saved, 2)
    end
    
    it "should be able to share base_items" do
      item = SpecFactory.gen(BaseItem, :saved)
      @item_manager1.add(item)
      @item_manager2.add(item)
      @item_manager1.item_hook[0].base_item_id.should  eql(item.id)
      @item_manager2.item_hook[0].base_item_id.should  eql(item.id)
    end
  end
end