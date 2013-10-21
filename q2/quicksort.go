package main

import (
  "fmt"
)

func quicksort(nums []int) []int {
  if len(nums) <= 1 {
    return nums
  }
  p := 0
  i := 0
  for j := 1; j < len(nums); j++ {
    if nums[j] < nums[p] {
      i++
      nums[i], nums[j] = nums[j], nums[i]
    }
  }
  nums[p], nums[i] = nums[i], nums[p]
  nums = append(append(quicksort(nums[:i]), nums[i]),  quicksort(nums[i+1:])...)
  return nums
}

func main() {
  a1 := []int{0,9,8,7,6,5,4,3,2,1}
  fmt.Printf("Quicksorting: %v\n",a1) 
  quicksort(a1)
  fmt.Printf("Sorted: %v\n",a1) 
}
