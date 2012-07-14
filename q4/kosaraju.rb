require 'set'
require 'csv'
require 'debugger'

@explored = []
@adj_nodes = {}
@time=0
@leaders={}
@source=0

def kosaraju(g)
  g.inject(@adj_nodes) do |sum, e|
    sum.has_key?(e[0]) ? (sum[e[0]] << e[1]) : (sum[e[0]]=[e[1]])
    sum
  end
  @adj_nodes.each_key {|v| @source=v; dfs(v)}
  puts "leaders: #{@leaders}, explored: #{@explored.sort}"
end

def dfs(s)
  unless @explored.include?(s)
    @explored << s
    @leaders[s]=@source
  end

  @adj_nodes[s].each do |v|
    dfs(v) unless @explored.include?(v) 
  end 
end

g=CSV.read("small.txt", :col_sep => " ", :converters => :numeric).sort

kosaraju g
