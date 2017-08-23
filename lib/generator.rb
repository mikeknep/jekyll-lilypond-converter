require "jekyll"

module Jekyll
  class LilyPondGenerator < Generator
    def generate(site)
      ::JekyllLilyPondConverter::SiteManager.instance.site = site
    end
  end
end
