require 'yaml'

module Catangerine
  class Configuration
    def self.configuration(game_type)
      YAML.load_file(File.dirname(__FILE__) + "/#{game_type.to_s}_configuration.yml")
    end
  end
end
