require "jekyll"

class MockJekyllSite < Jekyll::Site
  attr_accessor :static_files

  def initialize
    @static_files = []
  end

  def source
    "/full/path/to/source"
  end
end
