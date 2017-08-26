require "jekyll"

module Jekyll
  class LilyPondGenerator < Generator
    def generate(site)
      ::JekyllLilyPondConverter::SiteManager.instance.site = site
      setup_lily_images_directory
      remove_stale_lily_image_references(site)
    end

    private

    def setup_lily_images_directory
      system("rm", "-rf", "lily_images/")
      system("mkdir", "lily_images/")
    end

    def remove_stale_lily_image_references(site)
      site.static_files.reject! do |static_file|
        /lily_images\/.*\.(svg|png)/.match?(static_file.path)
      end
    end
  end
end
