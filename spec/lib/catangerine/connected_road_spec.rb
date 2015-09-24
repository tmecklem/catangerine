require 'spec_helper'

describe ConnectedRoad do
  let(:game_manager) { Catangerine::GameManager.new(player_count: 1).start_game }
  let(:board) { game_manager.board }
  let(:road_segments) {
    road_locations.map do |location_string|
      location = Catangerine::Location.new(*location_string.split(','))
      road = Catangerine::Road.new(nil)
      board.add_road(road, location)
      road
    end
  }
  let(:connected_road) { ConnectedRoad.new(road_segments: road_segments) }

  context '#longest_path' do
    context 'simple path' do
      let(:road_locations) { ['A,nw', 'A,w', 'A,sw', 'G,nw', 'G,w'] }

      it 'calculates the correct path' do
        expect(connected_road.length).to eq 5
      end
    end

    context 'forked path' do
      let(:road_locations) { ['A,nw', 'B,sw', 'A,w', 'A,sw', 'G,nw', 'G,w'] }

      it 'calculates the correct path' do
        expect(connected_road.length).to eq 5
      end
    end

    context 'cycle in path' do
      let(:road_locations) { ['A,nw', 'A,w', 'A,sw', 'E,nw', 'F,w', 'G,sw'] }

      it 'calculates the correct path' do
        expect(connected_road.length).to eq 6
      end
    end

    context 'cycles and forks in path' do
      let(:road_locations) { ['A,nw', 'A,w', 'A,sw', 'E,nw', 'F,w', 'G,sw', 'D,nw', 'F,nw'] }

      it 'calculates the correct path' do
        expect(connected_road.length).to eq 7
      end
    end
  end
end
