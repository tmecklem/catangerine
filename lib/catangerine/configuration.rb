require 'yaml'

module Catangerine
  class Configuration
    def self.default_configuration
      YAML.load_file(File.dirname(__FILE__) + '/standard_configuration.yml')
    end
  end
end
