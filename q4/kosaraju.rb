require 'ccsv'
require 'set'
require 'progressbar'
require 'debugger'
#require 'rubygems'
#require 'fastercsv'

@explored=Set.new
@finished=Set.new
@adj_nodes={}
@rev_nodes={}
@time=0
@finish_times={}
@leaders={}
@source=0

def trampoline(&thunk)
  thunk = thunk.call while thunk.respond_to?(:call)
  thunk
end

def kosaraju(file)
  #pbar = ProgressBar.new("graph hash", 8689)
  pbar = ProgressBar.new("graph hash", 5105043)
  Ccsv.foreach(file) do |row|
    i=row[0].split(" ")
    u=i[0].to_i
    v=i[1].to_i
    @adj_nodes.has_key?(u) ? (@adj_nodes[u] << v) : (@adj_nodes[u]=[v])
    @rev_nodes.has_key?(v) ? (@rev_nodes[v] << u) : (@rev_nodes[v]=[u])
    pbar.inc
  end
  pbar.finish
  puts 'normal and reverse graph created'

  #@n=1000
  @n=875714
  i=@n
  #puts "revg: #{@rev_nodes}"
  pbar = ProgressBar.new("reverse dfs", @n)
  while i > 0
    @source=i
    dfs(@rev_nodes, i)
    pbar.inc
    i -= 1
  end
  pbar.finish
  #puts "finishing times: #{@finish_times}"

  @leaders={}
  @explored=Set.new
  @finished=Set.new
  times = @finish_times.clone
  @time=0
  @finish_times={}
  puts 'variables initialized'
  pbar = ProgressBar.new("times dfs", @n)
  i=@n
  while i > 0
    @source = i
   dfs(@adj_nodes, times[i])
    pbar.inc
   i -= 1
  end
  pbar.finish
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

    #puts 'finished?'
    if @finished.include?(curr)
      stack.pop
    else

    #puts 'included?'
      unless @explored.include?(curr)
        @explored << curr
        @leaders[curr]=@source
      end

    #puts 'children?'
      if g[curr].nil? || (g[curr].to_set-@explored).empty?
        unless @finished.include?(curr)
          @time += 1
          @finish_times[@time]=curr
          @finished << curr
        end
          stack.pop
      else
        #puts 'unexplored?'
        unexplored = g[curr].to_set-@explored
        stack << unexplored.to_a.last
      end

    end
  end

  ## Recursive Approach ##
  #return if @explored.include?(s)

  #@explored << s
  #@leaders[s]=@source

  #if g[s]
    #g[s].each do |v|
      ##trampoline {dfs(g,v)} unless @explored.include?(v)
      #dfs(g,v) unless @explored.include?(v)
    #end 
  #end

  #@time += 1
  #@finish_times[@time]=s
end


#g=CSV.read("SCC.txt", :col_sep => " ", :converters => :numeric)
#puts 'file read'
kosaraju 'SCC.txt'
#kosaraju 'smaller.txt'
