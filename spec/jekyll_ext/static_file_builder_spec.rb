require "rspec"

describe StaticFileBuilder do
  let(:mock_site) { double(:mock_site, source: "source") }
  let(:mock_static_file) { double(:mock_static_file) }
  let(:image_filename) { "lily.svg" }

  describe "#build" do
    it "creates and returns a Jekyll::StaticFile" do
      expect(Jekyll::StaticFile).to receive(:new).with(
        mock_site,
        mock_site.source,
        "lily_images",
        image_filename
      ).and_return(mock_static_file)

      static_file = described_class.build(mock_site, image_filename)

      expect(static_file).to eq(mock_static_file)
    end
  end
end
