require "spec_helper"

describe JekyllLilyPondConverter::Handler do
  describe "#execute" do
    let(:content) { content_with_lily_snippets }
    let(:naming_policy) { MockNamingPolicy.new }
    let(:image_format) { "svg" }
    let(:site_manager) { MockSiteManager.new }
    let(:static_file_builder) { MockStaticFileBuilder }

    let(:handler) { described_class.new(
      content: content,
      naming_policy: naming_policy,
      image_format: image_format,
      site_manager: site_manager,
      static_file_builder: static_file_builder
    ) }

    before(:each) { `mkdir lily_images/` }
    after(:each) { `rm -rf lily_images/` }

    context "generating images" do
      it "generates SVG files with lilypond for all lily code snippets" do
        handler.execute

        expect(File.exist?("lily_images/uuid1.svg")).to eq(true)
        expect(File.exist?("lily_images/uuid2.svg")).to eq(true)
      end

      context "when image format is configured to png" do
        let(:image_format) { "png" }

        it "generates PNG files with lilypond for all lily code snippets" do
          handler.execute

          expect(File.exist?("lily_images/uuid1.png")).to eq(true)
          expect(File.exist?("lily_images/uuid2.png")).to eq(true)
        end
      end

      it "adds the lily images to the site's static file collection" do
        handler.execute

        expect(site_manager.static_files).to eq(["uuid1.svg", "uuid2.svg"])
      end
    end

    context "modifying content" do
      it "replaces lily code snippets with links to generated SVG files" do
        expect(handler.execute).to eq(content_with_lily_image_links)
      end

      context "when content does not have lily code snippets" do
        let(:content) { content_with_ruby_snippet }

        it "does not affect content with non-lily code snippets" do
          expect(handler.execute).to eq(content_with_ruby_snippet)
        end
      end
    end
  end
end
