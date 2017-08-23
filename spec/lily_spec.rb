require "spec_helper"

describe JekyllLilyPondConverter::Lily do
  let(:snippet) {
<<-SNIPPET
```lily
\\relative {
<c' e g>
}
```
SNIPPET
  }

  let(:lily) { described_class.new("123", snippet) }

  describe "#code_filename" do
    it "uses the given id and a .ly extension" do
      expect(lily.code_filename).to eq("123.ly")
    end
  end

  describe "#image_filename" do
    it "uses the given id and a .svg extension" do
      expect(lily.image_filename).to eq("123.svg")
    end
  end

  describe "#image_link" do
    it "returns a markdown inline-image link" do
      expect(lily.image_link).to eq("![](images/123.svg)\n")
    end
  end

  describe "#code" do
    it "returns the raw lily code without markdown code block delimiters" do
      expected_code = <<-CODE
\\relative {
<c' e g>
}
      CODE

      expect(lily.code).to eq(expected_code)
    end
  end
end
