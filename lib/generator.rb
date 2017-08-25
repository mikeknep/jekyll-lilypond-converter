require "jekyll"

module Jekyll
  class LilyPondGenerator < Generator
    def generate(site)
      ::JekyllLilyPondConverter::SiteManager.instance.site = site
      setup_lily_images_directory
    end

    private

    def setup_lily_images_directory
      system("rm", "-rf", "lily_images/")
      system("mkdir", "lily_images/")
    end
  end
end
