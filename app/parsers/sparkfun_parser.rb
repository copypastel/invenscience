require 'rubygems'
require 'mechanize'
require 'hpricot'

module SparkfunParser
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

class Warehouse
  #def query(search_string)
  #  raise "This is not implemented!"
  #end
#  include SparkfunParser
  
  def set_parser(parser)
    self.class.class_eval do 
      include parser
    end
    puts parser.to_s
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

sparkFun = Warehouse.new
begin 
  puts sparkFun.query('arduino')
rescue
  puts "Tada not implemented"
end

sparkFun.set_parser(SparkfunParser)

puts sparkFun.query('arduino')