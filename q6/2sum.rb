require 'set'
require 'progressbar'
require 'debugger'

class TwoSum
  def initialize(file)
    @file = file
    @i = Set.new
    @sums = Set.new
  end

  def run
    pbar = ProgressBar.new("Reading in integers", 500000)
    IO.foreach(@file) do |line|
      i =  line.chomp.to_i
      @i << i if i <= 4000
      pbar.inc
    end
    pbar.finish
    puts "Imported integers: #{@i.size}"

    pbar2 = ProgressBar.new("Counting sums", @i.size)
    (2500..4000).each do |t|
      @i.each do |i|
        if @i.include?(t-i)
          @sums<<t unless i == (t-i)
        end
      end
      pbar2.inc
    end
    pbar2.finish
    #debugger
    puts "Sums: #{@sums.size}"

  end
end
TwoSum.new('HashInt.txt').run
