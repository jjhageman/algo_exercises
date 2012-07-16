#require 'set'
require 'csv'
require 'debugger'
#require 'rubygems'
#require 'fastercsv'

@explored=[]
@adj_nodes={}
@rev_nodes={}
@time=0
@finish_times={}
@leaders={}
@source=0

def kosaraju(g)
  g.each do |e|
    @adj_nodes.has_key?(e[0]) ? (@adj_nodes[e[0]] << e[1]) : (@adj_nodes[e[0]]=[e[1]])
    @rev_nodes.has_key?(e[1]) ? (@rev_nodes[e[1]] << e[0]) : (@rev_nodes[e[1]]=[e[0]])
  end

  #@n=1000
  @n=875714
  i=@n
  #puts "revg: #{@rev_nodes}"
  while i > 0
    @source=i
    dfs(@rev_nodes, i)
    i -= 1
  end

  #puts "finishing times: #{@finish_times}"

  @leaders={}
  @explored=[]
  times = @finish_times.clone
  @finish_times={}

  i=@n
  while i > 0
    @source = i
   dfs(@adj_nodes, times.key(i))
   i -= 1
  end
  puts "end"
  counts = @leaders.group_by{|a,b| b}
  sizes = counts.values.map{|v| v.size}
  #puts "leaders: #{@leaders}"
  puts "sizes: #{sizes.sort.reverse[0..5]}"
end

def dfs(g,s)

  ## Iterative Approach ##
  stack = [s]
  until stack == []
    curr = stack[-1]

    if @finish_times.has_key?(curr)
      stack.pop
    else

      unless @explored.include?(curr)
        @explored << curr
        @leaders[curr]=@source
      end

      if g[curr].nil? || (g[curr]-@explored).empty?
        unless  @finish_times.has_key?(curr)
          @time += 1
          @finish_times[curr]=@time
        end
          stack.pop
      else
        unexplored = g[curr]-@explored
        stack << unexplored.last
      end

    end
  end

  ## Recursive Approach ##
  #return if @explored.include?(s)

  #@explored << s
  #puts "s: #{s}, source: #{@source}"
  #@leaders[s]=@source

  #if g[s]
    #g[s].each do |v|
      #dfs(g,v) unless @explored.include?(v)
    #end 
  #end

  #@time += 1
  #@finish_times[s]=@time
end

g=CSV.read("SCC.txt", :col_sep => " ", :converters => :numeric)

kosaraju g
