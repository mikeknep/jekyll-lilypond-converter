# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "version"

Gem::Specification.new do |spec|
  spec.name          = "jekyll-lilypond-converter"
  spec.version       = JekyllLilyPondConverter::VERSION
  spec.authors       = ["Mike Knepper"]
  spec.email         = ["michaelrknepper@gmail.com"]

  spec.summary       = "Convert LilyPond snippets in blog posts to images"
  spec.description   = "Automatically identify LilyPond code snippets in Markdown blog posts and, during conversion to HTML, replace snippets with links to generated SVG images"
  spec.homepage      = "https://github.com/mikeknep/jekyll-lilypond-converter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib", "lib/jekyll_ext/", "lib/jekyll_lilypond_converter/"]

  spec.add_dependency "jekyll", ">= 3.0"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rspec", "~> 3.6"
end
