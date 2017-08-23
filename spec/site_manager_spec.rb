require "spec_helper"

describe JekyllLilyPondConverter::SiteManager do
  let(:mock_site) { MockJekyllSite.new }
  let(:mock_static_file) { double(:mock_static_file) }
  let(:image_filename) { "lily.svg" }

  it "adds a static file to it's static file collection" do
    manager = described_class.instance
    manager.site = mock_site

    expect(Jekyll::StaticFile).to receive(:new).with(
      mock_site,
      mock_site.source,
      "",
      image_filename
    ).and_return(mock_static_file)

    manager.add_image("lily.svg")

    expect(mock_site.static_files).to eq([mock_static_file])
  end

end
