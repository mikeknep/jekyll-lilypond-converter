require "singleton"

module JekyllLilyPondConverter
  class SiteManager
    include Singleton

    attr_accessor :site

    def add_image(builder, filename)
      site.static_files << builder.build(site, filename)
    end

  end
end
