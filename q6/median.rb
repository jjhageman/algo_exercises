require 'set'
require 'progressbar'
require 'debugger'

class Median
  def initialize(file)
    @file = file
    @h = SortedSet.new
    @sum = 0
  end

  def run
    pbar = ProgressBar.new("Reading in integers", 10000)
    IO.foreach(@file) do |line|
      @h << line.chomp.to_i
      capture_median
      pbar.inc
    end
    pbar.finish
    puts "Sum: #{@sum}, mod: #{@sum%10000}"
  end

  def capture_median
    mid = @h.size/2
    med = @h.size%2==0 ? mid-1 : mid
    @sum += @h.to_a[med]
  end
end

Median.new('Median.txt').run
