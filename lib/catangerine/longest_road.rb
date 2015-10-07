class LongestRoad
  attr_reader :road_segments

  def initialize(road_segments:)
    @road_segments = road_segments
  end

  def longest_path
    return [] if road_segments.empty?
    road_segments.map { |segment|
      longest_path_from_segment(segment)
    }.max_by(&:length)
  end

  def length
    longest_path.length
  end

  private

  # performs a depth first traversal of the graph from segment to all unvisited neighbor segments
  # returns array of road segments that constitute the longest path found
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
      unvisited = !visited_segments.include?(connected_segment)
      fork_in_path = unvisited && fork?(connected_segment, visited_segments[-1], visited_segments[-2])
      connected_segment if unvisited && !fork_in_path
    }.compact
  end

  def fork?(segment1, segment2, segment3)
    return false if segment3.nil?
    (segment1.vertices & segment2.vertices & segment3.vertices).first
  end
end
