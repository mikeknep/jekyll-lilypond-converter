require "securerandom"

module JekyllLilyPondConverter
  class NamingPolicy
    def generate_name
      SecureRandom.uuid
    end
  end
end
