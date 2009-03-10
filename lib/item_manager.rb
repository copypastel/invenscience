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
    if (result = item.save) then  self.item_hook.reload; end
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
    if(result = item.save) then item_hook.reload; end
    result
  end
end
=begin
  def self.included(child_class)
    child_class.class_eval do
      #TODO: figure out why you cant use cattr_reader :child_class
      @@child_class = child_class
      @@item_hook = nil
      @@item_class_hook = nil
      def self.child_class; @@child_class; end
      def item_hook; self.send(@@item_hook); end
      def item_class_hook; @@item_class_hook; end
      def self.item_hook=(val); @@item_hook = val; end
      def self.item_class_hook=(val); @@item_hook = val; end
      extend ClassMethods
    end
  end
  module ClassMethods
  #  def self.extended(child_class)
  #    @child_class = child_class
  # end
    
    def initialize_item_manager(opts = {})
      item_join_class = opts[:item_join_class]
      item_join_str   = opts[:item_join_class].to_s
      item_join_sym   = opts[:item_join_class].to_s.snake_case.pluralize.to_sym
      puts item_join_str
      puts item_join_sym
      puts item_join_class
      self.child_class.class_eval do
        has n, item_join_sym
        has n, :base_items, :through => DataMapper::Resource, :class_name => item_join_str

        item_hook       = item_join_sym
        item_class_hook = item_join_class
      end
    end    
  end
end
=end