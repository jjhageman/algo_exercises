package main

import (
  "fmt"
  "os"
  "bufio"
  "strconv"
)

func merge(left, right []int) (merged []int) {
  i, j := 0,0
  for k := 0; k < len(left)+len(right); k++ {
    if i >= len(left) {
      merged = append(merged, right[j])
      j++
    } else if j >= len(right) {
      merged = append(merged, left[i])
      i++
    } else if left[i] <= right[j] {
      merged = append(merged, left[i])
      i++
    } else {
      merged = append(merged, right[j])
      j++
    }
  }
  return merged
}

func mergeSort(list []int) ([]int) {
  if len(list) > 1 {
    mid := len(list)/2
    left := list[0:mid]
    right := list[mid:]
    return merge(mergeSort(left), mergeSort(right))
  } 
  return list
}

func readInts(fileName string) (nums []int, err error) {
  f, err := os.Open(fileName)
  if err != nil { return nil, err }

  defer f.Close()
  
  scanner := bufio.NewScanner(f)
  scanner.Split(bufio.ScanWords)
  for scanner.Scan() {
    x, err := strconv.Atoi(scanner.Text())
    if err != nil { return nil, err }
    nums = append(nums, x)
  }
  return
}

func main() {
  file := "TestArray.txt"
  fmt.Printf("Importing data from '%s'\n", file)
  ints, err := readInts(file)
  if err != nil { panic(err) }
  fmt.Printf("Sorting %v\n", ints)
  sorted := mergeSort(ints)
  fmt.Println(sorted)
}
