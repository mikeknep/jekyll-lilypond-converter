require "spec_helper"

describe JekyllLilyPondConverter::Handler do
  describe "#execute" do
    let(:svg1) { double(:svg1) }
    let(:svg2) { double(:svg2) }
    let(:mock_jekyll_site) { MockJekyllSite.new }

    before(:each) do
      JekyllLilyPondConverter::SiteManager.instance.site = mock_jekyll_site
      stub_jekyll_static_file_instantiation
      `mkdir lily_images/`
    end

    after(:each) { `rm -rf lily_images/` }

    context "generating images" do
      it "generates SVG files with lilypond for all lily code snippets" do
        handler = described_class.new(content_with_lily_snippets, MockNamingPolicy.new, "svg")
        handler.execute

        expect(File.exist?("lily_images/uuid1.svg")).to eq(true)
        expect(File.exist?("lily_images/uuid2.svg")).to eq(true)
      end

      it "adds the lily images to the site's static file collection" do
        handler = described_class.new(content_with_lily_snippets, MockNamingPolicy.new, "svg")
        handler.execute

        expect(JekyllLilyPondConverter::SiteManager.instance.site.static_files).to eq([svg1, svg2])
      end
    end

    context "modifying content" do
      it "replaces lily code snippets with links to generated SVG files" do
        handler = described_class.new(content_with_lily_snippets, MockNamingPolicy.new, "svg")

        expect(handler.execute).to eq(content_with_lily_image_links)
      end

      it "does not affect content with non-lily code snippets" do
        handler = described_class.new(content_with_ruby_snippet, MockNamingPolicy.new, "svg")

        expect(handler.execute).to eq(content_with_ruby_snippet)
      end
    end
  end
end
