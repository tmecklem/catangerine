VERTEX = EDGE = Transform /^(\-?\w+),(\w+)$/ do |name, direction|
  Catangerine::Location.new(name, direction)
end
