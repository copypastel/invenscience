#in order to use you must alias item_hook to the method name for accessing the join between the destination and the base_item
module ItemManager
  def add(item,quantity = 1)
    #the item must be valid and already be saved
    return false unless item.valid? and not item.id.nil?

    if item.class == BaseItem
      base_item = item
      item = self.item_hook.first(:conditions => {:base_item_id => item.id}) ||
             self.item_hook.create(:base_item_id => base_item.id)
    ##else if the item is the join class for this ItemManager and the 
    #elsif (item.class == self.item_class_hook and item.send(self.class.snake_case) != self) or item.respond_to?(:base_item)
    #else if the item is join item and has a base_item
    elsif item.respond_to?(:base_item)
      item = self.item_hook.first(:conditions => {:base_item_id => item.base_item.id}) ||
             self.item_hook.create(:base_item_id => item.base_item.id)
    end

    item.quantity += quantity
    if (result = item.save) then self.item_hook.reload; end
    result
  end
  
  def remove(item, quantity = 1)
    if item.class == BaseItem
      item = self.item_hook(:conditions => {:base_item_id => item.id}).first
    elsif item.respond_to?(:base_item)
      item = self.item_hook(:conditions => {:base_item_id => item.base_item.id}).first
    end
    return false if item.nil?

    item.quantity -= quantity
    
    if(result = item.save) then self.item_hook.reload; end
    result
  end
end