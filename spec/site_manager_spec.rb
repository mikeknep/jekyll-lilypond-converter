require "rspec"
require "./lib/site_manager"

describe JekyllLilyPondConverter::SiteManager do
  let(:mock_site) { MockSite.new }
  let(:mock_static_file) { double(:mock_static_file) }
  let(:image_filename) { "lily.svg" }

  it "adds a static file to it's static file collection" do
    manager = described_class.instance
    manager.site = mock_site

    expect(Jekyll::StaticFile).to receive(:new).with(
      mock_site,
      mock_site.source,
      "images",
      image_filename
    ).and_return(mock_static_file)

    manager.add_image("lily.svg")

    expect(mock_site.static_files).to eq([mock_static_file])
  end

  class MockSite < Jekyll::Site
    attr_accessor :static_files

    def initialize
      @static_files = []
    end

    def source
      "/full/path/to/source"
    end
  end
end
