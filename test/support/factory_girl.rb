# Load Factories
require 'factory_girl'
Dir["#{File.dirname(__FILE__)}/../factories/*.rb"].each {|f| require f}
