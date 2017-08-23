require "jekyll"
require "singleton"

module JekyllLilyPondConverter
  class SiteManager
    include Singleton

    attr_accessor :site

    def add_image(filename)
      site.static_files << Jekyll::StaticFile.new(
        site,
        site.source,
        "",
        filename
      )
    end

  end
end
