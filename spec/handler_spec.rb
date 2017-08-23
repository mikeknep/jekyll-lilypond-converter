require "spec_helper"

describe JekyllLilyPondConverter::Handler do
  describe "#execute" do
    let(:svg1) { double(:svg1) }
    let(:svg2) { double(:svg2) }

    before(:each) do
      allow(SecureRandom).to receive(:uuid).and_return("uuid1", "uuid2")
      mock_jekyll_site = MockJekyllSite.new
      JekyllLilyPondConverter::SiteManager.instance.site = mock_jekyll_site
      allow(Jekyll::StaticFile).to receive(:new).with(
        mock_jekyll_site,
        mock_jekyll_site.source,
        "lily_images",
        "uuid1.svg"
      ).and_return(svg1)
      allow(Jekyll::StaticFile).to receive(:new).with(
        mock_jekyll_site,
        mock_jekyll_site.source,
        "lily_images",
        "uuid2.svg"
      ).and_return(svg2)
    end

    before(:each) { `mkdir lily_images/` }
    after(:each) { `rm -rf lily_images/` }

    context "generating images" do
      it "generates SVG files with lilypond for all lily code snippets" do
        handler = described_class.new(Content_with_lily_snippets)
        handler.execute

        expect(File.exist?("lily_images/uuid1.svg")).to eq(true)
        expect(File.exist?("lily_images/uuid2.svg")).to eq(true)
      end

      it "adds the lily images to the site's static file collection" do
        handler = described_class.new(Content_with_lily_snippets)
        handler.execute

        expect(JekyllLilyPondConverter::SiteManager.instance.site.static_files).to eq([svg1, svg2])
      end
    end

    context "modifying content" do
      it "replaces lily code snippets with links to generated SVG files" do
        handler = described_class.new(Content_with_lily_snippets)

        expect(handler.execute).to eq(Content_with_lily_image_links)
      end

      it "does not affect content with non-lily code snippets" do
        handler = described_class.new(Content_with_ruby_snippet)

        expect(handler.execute).to eq(Content_with_ruby_snippet)
      end
    end
  end
end


Content_with_lily_snippets = <<-EOC
C major.

```lily
\\relative {
<c' e g>
}
```

C minor.

```lily
\\relative {
<c' ees g>
}
```

End
EOC


Content_with_lily_image_links = <<-EOC
C major.

![](lily_images/uuid1.svg)

C minor.

![](lily_images/uuid2.svg)

End
EOC


Content_with_ruby_snippet = <<-EOC
This is Ruby

```ruby
def foo(x)
end
```

End
EOC
