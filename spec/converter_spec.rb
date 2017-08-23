require "spec_helper"

describe Jekyll::LilyPondConverter do
  let(:converter) { described_class.new }

  describe "#matches" do
    it "matches all markdown files (.md | .markdown)" do
      expect(converter.matches(".md")).to eq(true)
      expect(converter.matches(".markdown")).to eq(true)
    end

    it "does not match other filetypes" do
      expect(converter.matches(".txt")).to eq(false)
    end
  end

  describe "#output_ext" do
    it "outputs an HTML file" do
      expect(converter.output_ext(".md")).to eq(".html")
    end
  end

  describe "#convert" do
    it "delegates to a JekyllLilyPondConverter::Handler" do
      content = "abc"
      handler_spy = HandlerSpy.new

      allow(JekyllLilyPondConverter::Handler).to receive(:new).with(content).and_return(handler_spy)

      converter.convert(content)

      expect(handler_spy.execute_was_called).to eq(true)
    end
  end

  class HandlerSpy
    attr_reader :execute_was_called

    def initialize
      @execute_was_called = false
    end

    def execute
      @execute_was_called = true
    end
  end
end
