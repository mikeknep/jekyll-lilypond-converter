require "spec_helper"

describe Jekyll::LilyPondGenerator do
  let(:generator) { described_class.new }
  let(:site) { double(:jekyll_site) }

  it "stores the Jekyll::Site object provided via #generate on the SiteManager singleton" do
    generator.generate(site)

    expect(JekyllLilyPondConverter::SiteManager.instance.site).to eq(site)
  end
end
