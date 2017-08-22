require "securerandom"

module JekyllLilyPondConverter
  class Handler
    def initialize(content)
      @content = content
    end

    def execute
      lilies.each do |lily|
        write_lily_code_file(lily)
        generate_lily_image(lily)
        replace_snippet_with_image_link(lily)
      end

      content
    end

    private
    attr_reader :content

    def write_lily_code_file(lily)
      open(lily.code_filename, 'w') do |code_file|
        code_file.puts(lily.code)
      end
    end

    def generate_lily_image(lily)
      `bin/run-lilypond.sh #{lily.code_filename} #{lily.image_filename}`
    end

    def replace_snippet_with_image_link(lily)
      content.gsub!(lily.snippet, lily.image_link)
    end

    def lilies
      lily_snippets.map do |snippet|
        Lily.new(SecureRandom.uuid, snippet)
      end
    end

    def lily_snippets
      content.scan(/```lily.+?```\n/m)
    end
  end
end
