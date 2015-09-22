module Catangerine
  class Harbor
    attr_reader :harbor_type
    attr_accessor :position

    def initialize(harbor_type)
      @harbor_type = harbor_type
    end
  end
end
