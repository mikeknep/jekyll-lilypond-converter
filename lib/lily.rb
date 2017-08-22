module JekyllLilyPondConverter
  class Lily
    attr_reader :snippet

    def initialize(id, snippet)
      @id = id
      @snippet = snippet
    end

    def code_filename
      "#{id}.ly"
    end

    def image_filename
      "#{id}.svg"
    end

    def image_link
      "![](images/#{image_filename})\n"
    end

    def code
      strip_delimiters(snippet)
    end

    private
    attr_reader :id

    def strip_delimiters(snippet)
      snippet.gsub(/```lily\n/, "").gsub(/```\n/, "")
    end
  end
end
