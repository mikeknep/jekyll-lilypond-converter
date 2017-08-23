require "rspec"
require "./spec/mock_jekyll_site"

Dir["./lib/*.rb"].each { |file| require file }

RSpec.configure do |config|
  config.before(:each) do
    JekyllLilyPondConverter::SiteManager.instance.site = nil
  end
end
