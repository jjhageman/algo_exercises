require 'csv'
require 'progressbar'
require 'debugger'

class Dijkstra
  def initialize(file)
    @file = file
    @graph = {}
    @x=[]
    @a={}
    @b={}
    @v=[]
  end

  def run
    # read file and create graph
    CSV.foreach(@file, :col_sep => "\t", :row_sep => "\t\r\n") do |row|
      @graph[row[0].to_i]=[]
      row[1..-1].each do |node|
        @graph[row[0].to_i] << node.split(',').map(&:to_i)
      end
    end

    @v = @graph.keys
    @x << @v.first
    @a[@v.first]=0
    @b[@v.first]=[]

    pbar = ProgressBar.new("crawling graph", @v.size)
    until (@v - @x).empty?
      min_len=1000000
      min_edge=[]
      @x.each do |v|
        debugger if @graph[v].nil?
        @graph[v].each do |n|
          next unless (@v-@x).include?(n[0])
          if (@a[v]+n[1]) < min_len
            min_len = @a[v]+n[1]
            min_edge = [v,n[0]]
          end
        end
      end

      @x << min_edge[1]
      pbar.inc
      @a[min_edge[1]]=min_len
      @b[min_edge[1]]=@b[min_edge[0]]|min_edge
    end
    pbar.finish
    
    puts "shortest distance #{@a}"
    puts "shortest path #{@b}"
  end
end

Dijkstra.new('dijkstraData.txt').run
