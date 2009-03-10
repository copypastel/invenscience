require File.join( File.dirname(__FILE__), 'base')

SpecFactory.define_valid Order do |o|
  o.set :project_id, SpecFactory.gen(Project, :saved).id
end
