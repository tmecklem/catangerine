require 'spec_helper'

module Catangerine
  describe Location do
    it 'starts in the center as A' do
      s = Location.new('A')
      expect([s.q, s.r]).to eq [0, 0]
    end

    it 'continues to the nw neighbor as B' do
      s = Location.new('B')
      expect([s.q, s.r]).to eq [0, -1]
    end

    it 'names tiles in counterclockwise assignment (C)' do
      s = Location.new('C')
      expect([s.q, s.r]).to eq [-1, 0]
    end

    it 'moves in expanding concentric circles (I)' do
      s = Location.new('I')
      expect([s.q, s.r]).to eq [-1, -1]
    end

    it 'continues at AA after A-Z' do
      s = Location.new('AA')
      expect([s.q, s.r]).to eq [-2, 3]
    end

    it 'accepts a direction component after the name' do
      s = Location.new('A', 't')
      expect([s.q, s.r, s.direction]).to eq [0, 0, :t]
    end

    it 'accepts coords instead of name' do
      s = Location.new(0, 0)
      expect([s.q, s.r]).to eq [0, 0]
    end

    it 'accepts a direction component after coords' do
      s = Location.new(0, 0, 't')
      expect([s.q, s.r, s.direction]).to eq [0, 0, :t]
    end
  end
end
