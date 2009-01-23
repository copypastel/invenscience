Invenscience
============

Invenscience aims to make maintaining and ordering a list of parts easy for all you electronic engineers out there.

Current Status
--------------

Still starting off and getting the backend working properly. In other words, views aren't being touched with a 10-foot pole just yet. Models and their respective specs are the sole receivers of our love for now.

Dependencies
------------

* merb
* merb-helpers
* merb-mailers
* merb-param-protection
* dm-aggregator
* dm-timestamps
* dm-types
* dm-validations
* mechanize

Models
------

### Parsers ###

Parsers are the interface to parts providers, which in this context refer to online vendors. Their job is to crunch on HTML for breakfast and spit out useful information on items and orders.

They live inside app/parsers, and should be namespaced inside the Parser module. Eventually, Parser::Generic will provide a starting point for those wanting to write parsers of their own. We're not there yet, though.

### Warehouses ###

Warehouses are the alter-egos to parts providers. In short, they represent a collection of items, and also serve as the gateway to parse websites (a Warehouse includes a Parser's methods).
#### New Warehouse
Setting a parser is easy and simple!

    w = Warehouse.new
    w.name = 'Sparkfun'
    w.parser = Parser::Sparkfun
    w.parse "http://www.sparkfun.com/commerce/product_info.php?products_id=9000" # => #<Item>

#### Existing Warehouse
But is not repeated excessively.

	w = Warehouse.first(:name => 'Sparkfun')
	w.parse "http://www.sparkfun.com/commerce/product_info.php?products_id=9000" # => #<Item>