module Catangerine
  class Harbor
    attr_reader :harbor_type

    def initialize(harbor_type)
      @harbor_type = harbor_type
    end
  end
end
