require 'rubygems'
require 'mechanize'
require 'hpricot'

class Supplier
  def query( search_string)
    agent = WWW::Mechanize.new
    items = []
    agent.get('http://www.sparkfun.com/commerce/categories.php') do |page|
      results = page.form_with(:name => 'quick_find') do |search|
        search.keywords = search_string
      end.submit

      doc = Hpricot(results.body)

      (doc/"a.product_name").each do |link|
        item = Item.new do |i|
          i.name = link.innerHTML
        end
        items << item
      end

    end
    items
  end
end


class Item
  attr_accessor :name
  attr_accessor :serial
  attr_accessor :price

  def initialize()
    yield self
  end
  
  def to_s
    name
  end
end

puts Supplier.new.query('arduino')