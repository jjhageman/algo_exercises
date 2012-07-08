require 'csv'
require 'msgpack'
require 'debugger'

def rand_edge(g)
  v=g.keys[rand(0..g.size-1)]
  u=g[v][rand(0..g[v].size-1)]
  [v,u]
end

def mincut(g)
  v,u = *rand_edge(g)
  g[v].concat(g[u]) # copy g[u] into g[v]
  #puts "v: #{v}, g[#{u}]: #{g[u]}"
  g[u].each { |i| g[i].map! { |j| j == u ? v : j } } # replace all u adjacencies with v
  g[v].delete(v) # remove self-loops
  g.delete(u) # remove g[u]
end

def karger(g)
  while g.size > 2 do
    mincut(g)
  end
   g[g.keys[0]].size
end

def deep_copy(value)
  #Marshal.load(Marshal.dump(value))
  MessagePack.unpack(value.to_msgpack)
end

g={}

CSV.foreach("kargerMinCut.txt", :col_sep => "\t", :row_sep => "\t\r\n", :converters => :integer) do |row|
  g[row[0]]=row[1..-1]
end

#g1=Hash[1=>[2,3],2=>[1,3,4,5],3=>[1,2,5],4=>[2,5,6],5=>[3,4,6,2],6=>[4,5]]
#g2=Hash[1=>[2,3,4],2=>[1,3,4],3=>[1,2,4],4=>[1,2,3]]
#g3=Hash[1=>[2,3],2=>[1,4],3=>[1,4],4=>[2,3]]
#g4=Hash[1=>[2,3,7], 2=>[1,3,4,5,7], 3=>[1,2,5,7], 4=>[2,5,6,7], 5=>[3,4,6,2,7], 6=>[4,5,7], 7=>[1,2,3,4,5,6]]

min_count = karger(deep_copy(g))

1000.times do
  cut = karger(deep_copy(g))
  min_count = cut if cut<min_count
end

puts min_count
