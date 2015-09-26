# This class represents the concept of a complete section of connected road segments.
# A player may have several of these.
class ConnectedRoad
  attr_reader :road_segments

  def initialize(road_segments: [])
    @road_segments = road_segments
  end

  def length
    longest_path.length
  end

  def longest_path
    road_segments.map { |segment|
      longest_path_from_segment(segment)
    }.max_by(&:length)
  end

  # performs a depth first traversal of the graph from segment to all unvisited neighbor segments
  # returns the longest path including all possible paths from visited_segments through segment
  def longest_path_from_segment(segment, visited_segments = [])
    visited_segments << segment
    unvisited_segments = unvisited_connected_segments(segment, visited_segments)
    return visited_segments if unvisited_segments.empty?
    further_visited_segments = unvisited_segments.map do |next_segment|
      longest_path_from_segment(next_segment, visited_segments.dup)
    end
    further_visited_segments.max_by(&:length)
  end

  def unvisited_connected_segments(segment, visited_segments)
    segment.connected_segments.map { |connected_segment|
      unvisited = !visited_segments.include?(connected_segment[:road])
      fork_in_path = unvisited && connected_segment[:vertex] == shared_vertex(visited_segments[-1], visited_segments[-2])
      connected_segment[:road] if unvisited && !fork_in_path
    }.compact
  end

  #used to determine if a vertex has already been visited. Since a vertex has three edges connected, a shared vertex of three roads by the same player indicates a fork in the road, so we detect this to keep from doubling back across the same vertex twice.
  def shared_vertex(segment1, segment2)
    return nil if segment2.nil?
    vertices = segment1.position.connections.map { |connection| connection[:vertex] }.uniq & segment2.position.connections.map { |connection| connection[:vertex] }.uniq
    vertices.first
  end
end
