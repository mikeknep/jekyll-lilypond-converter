# Jekyll LilyPond Converter

Add `lily` code blocks to your markdown blog post and automatically convert the code to sheet music using [LilyPond][].

### Installation and Usage

- [Install LilyPond][] and ensure the `lilypond` executable is on your `$PATH`
- Add this gem to your Jekyll-based static site repository's Gemfile
- Add `lily_images/` to your `.gitignore`
- Add the converter to your `_config.yml` file:

      gems:
      - jekyll-lilypond-converter

- (Optional) specify LilyPond image format in `_config.yml` (default is `svg`, alternative option is `png`)

      lilypond-image-format: png

- Add lily code to a markdown post:

      This is a C major chord:

      ```lilypond
      \relative {
        <c' e g>
      }
      ```


[LilyPond]: http://lilypond.org/
[Install LilyPond]: http://lilypond.org/download.html
