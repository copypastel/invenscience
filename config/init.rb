# Go to http://wiki.merbivore.com/pages/init-rb
 
require 'config/dependencies.rb'
require 'open-uri'
 
use_orm :datamapper
use_test :rspec
use_template_engine :erb
 
Merb::Config.use do |c|
  c[:use_mutex] = false
  c[:session_store] = 'cookie'  # can also be 'memory', 'memcache', 'container', 'datamapper
  
  # cookie session store configuration
  c[:session_secret_key]  = 'f47a829ba3d2618f3d15c5b9ae5c707b416730c1'  # required for cookie session store
  # c[:session_id_key] = '_session_id' # cookie session id key, defaults to "_session_id"
end
 
Merb::BootLoader.before_app_loads do
  # This will get executed after dependencies have been loaded but before your app's classes have loaded.
  Merb.push_path(:parser, Merb.root / 'app' / 'parsers')
  Merb::BootLoader::LoadClasses.load_classes( Merb.root / 'app' / 'parsers' / '*')
end
 
Merb::BootLoader.after_app_loads do
end
