require "jekyll"

module Jekyll
  class LilyPondConverter < Converter
    priority :high

    def matches(ext)
      /md|markdown/.match?(ext)
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      naming_policy = ::JekyllLilyPondConverter::NamingPolicy.new

      ::JekyllLilyPondConverter::Handler.new(content, naming_policy).execute
    end
  end
end
