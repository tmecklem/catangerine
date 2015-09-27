require 'spec_helper'

module Catangerine
  describe LocationTranslator do
    it 'starts in the center as A' do
      expect(LocationTranslator.location_for('A')).to eq [0, 0]
      expect(LocationTranslator.name_for([0, 0])).to eq 'A'
    end

    it 'continues to the nw neighbor as B' do
      expect(LocationTranslator.location_for('B')).to eq [0, -1]
      expect(LocationTranslator.name_for([0, -1])).to eq 'B'
    end

    it 'names tiles in counterclockwise assignment (C)' do
      expect(LocationTranslator.location_for('C')).to eq [-1, 0]
      expect(LocationTranslator.name_for([-1, 0])).to eq 'C'
    end

    it 'moves in expanding concentric circles (I)' do
      expect(LocationTranslator.location_for('I')).to eq [0, -2]
      expect(LocationTranslator.name_for([0, -2])).to eq 'I'
    end

    it 'continues at AA after A-Z' do
      expect(LocationTranslator.location_for('AA')).to eq [-3, 2]
      expect(LocationTranslator.name_for([-3, 2])).to eq 'AA'
    end
  end
end
