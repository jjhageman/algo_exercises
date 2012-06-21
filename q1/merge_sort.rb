require 'csv'
require 'debugger'

def merge_sort(list)
  return list if list.size <= 1
  mid = list.size/2
  left = list[0,mid]
  right = list[mid, list.size-mid]
  #puts "whole: #{list.join(',')}, length: #{list.size}, mid: #{mid}, left: #{left.join(',')}, right: #{right.join(',')}"
  left = merge_sort(left)
  right = merge_sort(right)
  merge(left,right)
end

def merge(left,right)
  sorted = []
  until left.empty? || right.empty?
    debugger
    if left.first <= right.first
      sorted << left.shift
    else
      sorted << right.shift
    end
  end
  puts sorted
end

f=CSV.read('TestArray.txt')
merge_sort f
