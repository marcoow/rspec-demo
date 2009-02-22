ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'spec/autorun'
require 'spec/rails'

require File.expand_path(File.dirname(__FILE__) + '/matchers/matchers')

Spec::Runner.configure do |config|
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  config.include(Matchers)
end

describe 'all non-redirecting actions', :shared => true do

  it 'should be a success' do
    do_request

    response.should be_success
  end

end
