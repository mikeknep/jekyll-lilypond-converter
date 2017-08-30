require "jekyll"

class StaticFileBuilder
  def self.build(site, filename)
    Jekyll::StaticFile.new(
      site,
      site.source,
      "lily_images",
      filename
    )
  end
end
