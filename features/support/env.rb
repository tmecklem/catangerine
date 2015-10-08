$LOAD_PATH.unshift(__dir__ + '/../../lib')
$LOAD_PATH.unshift(__dir__ + '/harnesses')

Dir[File.dirname(__FILE__) + "/matchers/*.rb"].each { |f| require f }

require 'pry'
require 'catangerine'
