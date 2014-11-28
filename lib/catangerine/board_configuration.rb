require 'yaml'

module Catangerine
  class BoardConfiguration
    def self.configuration(game_type)
      YAML.load_file(File.dirname(__FILE__) + "/#{game_type.to_s}_board_configuration.yml")
    end
  end
end
