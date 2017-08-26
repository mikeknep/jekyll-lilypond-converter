require "securerandom"

module JekyllLilyPondConverter
  class Handler
    def initialize(content, naming_policy)
      @content = content
      @naming_policy = naming_policy
    end

    def execute
      lilies.each do |lily|
        write_lily_code_file(lily)
        generate_lily_image(lily)
        add_lily_image_to_site(lily)
        replace_snippet_with_image_link(lily)
      end
      content
    end

    private
    attr_reader :content, :naming_policy

    def write_lily_code_file(lily)
      open(lily.code_filename, 'w') do |code_file|
        code_file.puts(lily.code)
      end
    end

    def generate_lily_image(lily)
      system("lily", "-dbackend=svg", lily.code_filename)
      system("mv", lily.image_filename, "lily_images/")
      system("rm", lily.code_filename)
    end

    def add_lily_image_to_site(lily)
      JekyllLilyPondConverter::SiteManager.instance.add_image(lily.image_filename)
    end

    def replace_snippet_with_image_link(lily)
      content.gsub!(lily.snippet, lily.image_link)
    end

    def lilies
      lily_snippets.map do |snippet|
        Lily.new(naming_policy.generate_name, snippet)
      end
    end

    def lily_snippets
      content.scan(/```lily.+?```\n/m)
    end
  end
end