require 'csv'
require 'debugger'

class Dijkstra
  def initialize(file)
    @file = file
  end

  def run
    # read file and create graph
    CSV.foreach(@file, :col_sep => "\t", :row_sep => "\t\n") do |row|
      debugger
      nil
    end

  end
end

Dijkstra.new('smaller.txt').run
