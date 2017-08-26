module JekyllLilyPondConverter
  class INVALID_IMAGE_FORMAT_ERROR < StandardError
    def message
      <<-ERROR
Invalid lilypond-image-format option selected.
Valid options are 'svg' (default) and 'png'.
      ERROR
    end
  end
end
