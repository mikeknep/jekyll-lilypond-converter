require "spec_helper"

describe JekyllLilyPondConverter::SiteManager do
  let(:mock_site) { MockJekyllSite.new }
  let(:mock_static_file) { double(:mock_static_file) }
  let(:image_filename) { "lily.svg" }

  describe "#add_image" do
    it "uses the provided builder to build a file with the given filename and add it to its site's static files" do
      manager = described_class.instance
      manager.site = mock_site

      manager.add_image(MockStaticFileBuilder, "lily.svg")

      expect(mock_site.static_files).to eq([{site: mock_site, filename: "lily.svg"}])
    end
  end

end
