require 'csv'
require 'debugger'
@@comparisons = 0
class Quicksort
 
  #def self.first_element(keys)
    #return keys if keys.nil? || keys.size <= 1
    #@@comparisons += (keys.size-1)
    #pivot=i=0
    #for j in (i+1)..(keys.size-1)
      #if keys[j] < keys[pivot]
        #i+=1
        #keys[i], keys[j] = keys[j], keys[i]
      #end
    #end
    #keys[pivot], keys[i] = keys[i], keys[pivot]
    #first_element(keys.take(i)) + [keys[i]] + first_element(keys[i+1..keys.size-1])
  #end

  #def self.final_element(keys)
    #return keys if keys.nil? || keys.size <= 1
    #keys[0], keys[keys.size-1] = keys[keys.size-1], keys[0]
    #@@comparisons += (keys.size-1)
    #pivot=i=0
    #for j in (i+1)..(keys.size-1)
      #if keys[j] < keys[pivot]
        #i+=1
        #keys[i], keys[j] = keys[j], keys[i]
      #end
    #end
    #keys[pivot], keys[i] = keys[i], keys[pivot]
    #final_element(keys.take(i)) + [keys[i]] + final_element(keys[i+1..keys.size-1])
  #end

  def self.median(keys)
    return keys if keys.nil? || keys.size <= 1
    three={}
    three[0]=keys[0]
    middle = keys.size%2==0 ? (keys.size/2)-1 : keys.size/2 
    three[middle]=keys[middle]
    three[keys.size-1]=keys[keys.size-1]
    median_value = three.values.sort[1]
    median_index = three.key(median_value)
    if median_index > 0
      keys[0], keys[median_index] = keys[median_index], keys[0]
    end
    @@comparisons += (keys.size-1)
    pivot=i=0
    for j in (i+1)..(keys.size-1)
      if keys[j] < keys[pivot]
        i+=1
        keys[i], keys[j] = keys[j], keys[i]
      end
    end
    keys[pivot], keys[i] = keys[i], keys[pivot]
    median(keys.take(i)) + [keys[i]] + median(keys[i+1..keys.size-1])
  end

  #def self.sort2(items)
   #return items if items.nil? or items.length <= 1
   #less, more = items[1..-1].partition { |i| i < items[0] }
   #sort2(less) + [items[0]] + sort2(more)
  #end
 
end
a1=[0,9,8,7,6,5,4,3,2,1]
a2=[0,1,2,3,4,5,6,7,8,9]
a3=[1,11,5,15,2,12,9,99,77,0]
f1=[9,6,3,7,4,2]
f2=[9,6,3,7,2,4]
f=CSV.read('QuickSort.txt', :converters => :numeric).flatten
Quicksort.median(f)
puts "Comparisons: #{@@comparisons}"
