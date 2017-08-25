require "spec_helper"

describe Jekyll::LilyPondGenerator do
  let(:generator) { described_class.new }
  let(:site) { double(:jekyll_site) }

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
end
