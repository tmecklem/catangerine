VERTEX = EDGE = Transform /^(\-?\d+),(\-?\d+),(\w+)$/ do |q, r, v|
  [q.to_i, r.to_i, v.to_sym]
end
