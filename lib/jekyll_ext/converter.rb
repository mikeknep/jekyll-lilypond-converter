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
      /md|markdown/.match(ext)
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      ::JekyllLilyPondConverter::Handler.new(
        content: content,
        naming_policy: ::JekyllLilyPondConverter::NamingPolicy.new,
        image_format: image_format,
        site_manager: ::JekyllLilyPondConverter::SiteManager.instance,
        static_file_builder: Jekyll::LilyPondStaticFileBuilder
      ).execute
    end

    private

    def image_format
      @config["lilypond-image-format"]
    end
  end
end
