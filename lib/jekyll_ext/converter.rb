require "jekyll"

module Jekyll
  class LilyPondConverter < Converter
    priority :high

    DEFAULT_CONFIG = {
      "lilypond-image-format" => "svg"
    }

    def initialize(config = {})
      @config = Jekyll::Utils.deep_merge_hashes(DEFAULT_CONFIG, config)
    end

    def matches(ext)
      /md|markdown/.match?(ext)
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      naming_policy = ::JekyllLilyPondConverter::NamingPolicy.new
      image_format = @config["lilypond-image-format"]
      site_manager = ::JekyllLilyPondConverter::SiteManager.instance
      ensure_valid_image_format(image_format)

      ::JekyllLilyPondConverter::Handler.new(content, naming_policy, image_format, site_manager).execute
    end

    private

    def ensure_valid_image_format(image_format)
      unless ["svg", "png"].include?(image_format)
        raise ::JekyllLilyPondConverter::INVALID_IMAGE_FORMAT_ERROR
      end
    end
  end
end
