require "rspec"
require "./lib/handler"

describe JekyllLilyPondConverter::Handler do
  describe "#execute" do
    after(:each) { `rm *.svg` }

    context "generating images" do
      it "generates SVG files with lilypond for all lily code snippets" do
        allow(SecureRandom).to receive(:uuid).and_return("uuid1", "uuid2")
        handler = described_class.new(Content_with_lily_snippets)
        handler.execute

        expect(File.exist?("uuid1.svg")).to eq(true)
        expect(File.exist?("uuid2.svg")).to eq(true)
      end
    end

    context "modifying content" do
      it "replaces lily code snippets with links to generated SVG files" do
        allow(SecureRandom).to receive(:uuid).and_return("uuid1", "uuid2")

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

![](images/uuid1.svg)

C minor.

![](images/uuid2.svg)

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
