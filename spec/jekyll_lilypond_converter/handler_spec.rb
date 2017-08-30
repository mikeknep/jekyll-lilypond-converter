require "spec_helper"

describe JekyllLilyPondConverter::Handler do
  describe "#execute" do
    let(:naming_policy) { MockNamingPolicy.new }
    let(:site_manager) { MockSiteManager.new }
    let(:static_file_builder) { MockStaticFileBuilder }

    before(:each) { `mkdir lily_images/` }
    after(:each) { `rm -rf lily_images/` }

    context "generating images" do
      it "generates SVG files with lilypond for all lily code snippets" do
        handler = described_class.new(content_with_lily_snippets, naming_policy, "svg", site_manager, static_file_builder)
        handler.execute

        expect(File.exist?("lily_images/uuid1.svg")).to eq(true)
        expect(File.exist?("lily_images/uuid2.svg")).to eq(true)
      end

      it "generates PNG files with lilypond for all lily code snippets" do
        handler = described_class.new(content_with_lily_snippets, naming_policy, "png", site_manager, static_file_builder)
        handler.execute

        expect(File.exist?("lily_images/uuid1.png")).to eq(true)
        expect(File.exist?("lily_images/uuid2.png")).to eq(true)
      end

      it "adds the lily images to the site's static file collection" do
        handler = described_class.new(content_with_lily_snippets, naming_policy, "svg", site_manager, static_file_builder)
        handler.execute

        expect(site_manager.static_files).to eq(["uuid1.svg", "uuid2.svg"])
      end
    end

    context "modifying content" do
      it "replaces lily code snippets with links to generated SVG files" do
        handler = described_class.new(content_with_lily_snippets, naming_policy, "svg", site_manager, static_file_builder)

        expect(handler.execute).to eq(content_with_lily_image_links)
      end

      it "does not affect content with non-lily code snippets" do
        handler = described_class.new(content_with_ruby_snippet, naming_policy, "svg", site_manager, static_file_builder)

        expect(handler.execute).to eq(content_with_ruby_snippet)
      end
    end
  end
end
