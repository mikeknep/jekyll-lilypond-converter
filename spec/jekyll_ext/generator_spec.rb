require "spec_helper"

describe Jekyll::LilyPondGenerator do
  let(:generator) { described_class.new }
  let(:site) { MockJekyllSite.new }

  after { system("rm", "-rf", "lily_images") }

  it "stores the Jekyll::Site object provided via #generate on the SiteManager singleton" do
    generator.generate(site)

    expect(JekyllLilyPondConverter::SiteManager.instance.site).to eq(site)
  end

  it "destroys any existing lily_images directory and creates a clean one" do
    system("mkdir" "lily_images/")
    system("touch", "lily_images/foo")

    generator.generate(site)

    expect(File.exists?("lily_images/foo")).to eq(false)
    expect(Dir.exists?("lily_images")).to eq(true)
  end

  it "removes stale lily image references from the Jekyll site" do
    stale_lily_svg = double(:stale_lily_svg, path: "/Users/foo/project/lily_images/abcde.svg")
    stale_lily_png = double(:stale_lily_png, path: "/Users/foo/project/lily_images/abcde.png")
    other_static_file = double(:other_static_file, path: "/Users/foo/project/images/foo.jpg")
    site = MockJekyllSite.new(static_files: [stale_lily_svg, stale_lily_png, other_static_file])
    generator.generate(site)

    expect(site.static_files).to eq([other_static_file])
  end
end
