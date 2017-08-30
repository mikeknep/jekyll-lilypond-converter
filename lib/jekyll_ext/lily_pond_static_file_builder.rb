require "jekyll"

module Jekyll
  class LilyPondStaticFileBuilder
    def self.build(site, filename)
      StaticFile.new(
        site,
        site.source,
        "lily_images",
        filename
      )
    end
  end
end
