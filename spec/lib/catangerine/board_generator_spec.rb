require 'spec_helper'

module Catangerine
  describe BoardGenerator do
    let!(:options) { Configuration.configuration(:standard) }
    subject { BoardGenerator.new(options) }

    context '#initialize' do
      it 'validates presence of required options' do
        required_fields = [:tile_counts, :chit_counts, :harbor_counts].shuffle
        required_fields.each do |required_field|
          options = Configuration.configuration(:standard)
          options.delete(required_field)
          expect {
            BoardGenerator.new(options)
          }.to raise_error(ArgumentError).with_message(/#{required_field.to_s}/)
        end
      end
    end

    context '#generate' do
      it 'generates a board' do
        expect(subject.generate).to_not be_nil
      end
    end
  end
end
