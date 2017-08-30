require "rspec"
require "jekyll"

Dir["./lib/**/*.rb"].each { |file| require file }

RSpec.configure do |config|
  config.before(:each) do
    JekyllLilyPondConverter::SiteManager.instance.site = nil
  end
end


class MockJekyllSite < Jekyll::Site
  attr_accessor :static_files

  def initialize(static_files: [])
    @static_files = static_files
  end

  def source
    "/full/path/to/source"
  end
end


class MockStaticFileBuilder
  def self.build(site, filename)
    {site: site, filename: filename}
  end
end


class MockNamingPolicy
  def initialize
    @names = ["uuid1", "uuid2"]
  end

  def generate_name
    @names.shift
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


class MockSiteManager
  attr_reader :static_files

  def initialize
    @static_files = []
  end

  def add_image(builder, filename)
    @static_files << filename
  end
end


def content_with_lily_snippets
<<-EOC
C major.

```lilypond
\\relative {
<c' e g>
}
```

C minor.

```lilypond
\\relative {
<c' ees g>
}
```

End
EOC
end


def content_with_lily_image_links
<<-EOC
C major.

![](/lily_images/uuid1.svg)

C minor.

![](/lily_images/uuid2.svg)

End
EOC
end


def content_with_ruby_snippet
<<-EOC
This is Ruby

```ruby
def foo(x)
end
```

End
EOC
end
