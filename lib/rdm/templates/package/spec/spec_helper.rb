ENV['RUBY_ENV'] = 'test'

require 'rdm'
Rdm.init(File.expand_path('../../', __FILE__), :test)

require 'rspec'
require 'pry'

RSpec.configure do |config|
end
