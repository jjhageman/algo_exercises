require 'debugger'

class Quicksort
 
  def self.sort(keys)
    pivot=i=0
    for j in (i+1)..(keys.size-1)
      if keys[j] < keys[pivot]
        i+=1
        keys[i], keys[j] = keys[j], keys[i]
      end
    end
    keys[pivot], keys[i] = keys[i], keys[pivot]
    sort()
    sort()
    keys
  end

  def self.sort!(keys)
    quick(keys,0,keys.size-1)
  end

  def self.sort2(items)
   return items if items.nil? or items.length <= 1
   less, more = items[1..-1].partition { |i| i < items[0] }
   sort2(less) + [items[0]] + sort2(more)
  end
 
  private
 
  def self.quick(keys, left, right)
    if left < right
      pivot = partition(keys, left, right)
      quick(keys, left, pivot-1)
      quick(keys, pivot+1, right)
    end
    keys
  end
 
  def self.partition(keys, left, right)
    x = keys[right]
    i = left-1
    for j in left..right-1
      if keys[j] <= x
        i += 1
        keys[i], keys[j] = keys[j], keys[i]
      end
    end
    keys[i+1], keys[right] = keys[right], keys[i+1]
    i+1
  end
 
end
a=[3,2,1,5,8,4,7,6]
puts Quicksort.sort(a)
