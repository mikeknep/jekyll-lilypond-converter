module JekyllLilyPondConverter
  class Handler
    def initialize(content:, naming_policy:, image_format:, site_manager:, static_file_builder:)
      @content = content
      @naming_policy = naming_policy
      @image_format = image_format
      @site_manager = site_manager
      @static_file_builder = static_file_builder
    end

    def execute
      ensure_valid_image_format

      lilies.each do |lily|
        write_lily_code_file(lily)
        generate_lily_image(lily)
        add_lily_image_to_site(lily)
        replace_snippet_with_image_link(lily)
      end
      content
    end

    private
    attr_reader :content, :naming_policy, :image_format, :site_manager, :static_file_builder

    def ensure_valid_image_format
      unless ["svg", "png"].include?(image_format)
        raise INVALID_IMAGE_FORMAT_ERROR
      end
    end

    def write_lily_code_file(lily)
      open(lily.code_filename, 'w') do |code_file|
        code_file.puts(lily.code)
      end
    end

    def generate_lily_image(lily)
      system("lilypond", lilypond_output_format_option, lily.code_filename)
      system("mv", lily.image_filename, "lily_images/")
      system("rm", lily.code_filename)
    end

    def add_lily_image_to_site(lily)
      site_manager.add_image(static_file_builder, lily.image_filename)
    end

    def replace_snippet_with_image_link(lily)
      content.gsub!(lily.snippet, lily.image_link)
    end

    def lilies
      lily_snippets.map do |snippet|
        Lily.new(naming_policy.generate_name, image_format, snippet)
      end
    end

    def lily_snippets
      content.scan(/```lilypond.+?```\n/m)
    end

    def lilypond_output_format_option
      image_format == "png" ? "--png" : "-dbackend=svg"
    end
  end
end
