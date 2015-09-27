require 'spec_helper'

module Catangerine
  describe Location do
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

    describe '#<=>' do
      context 'location coords are the same' do
        it 'returns 0 if both directions are nil' do
          expect(Location.new('A') <=> Location.new('A')).to eq 0
        end

        it 'returns -1 if left side direction is nil and right side direction is set' do
          expect(Location.new('A') <=> Location.new('A', :t)).to eq(-1)
        end

        it 'returns 0 if both directions match' do
          expect(Location.new('A', :t) <=> Location.new('A', :t)).to eq 0
        end
      end
    end
  end
end
