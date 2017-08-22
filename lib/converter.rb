require "jekyll"

module Jekyll
  class LilyPondConverter < Converter
    def matches(ext)
      /md|markdown/.match?(ext)
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      ::JekyllLilyPondConverter::Handler.new(content).execute
    end
  end
end
