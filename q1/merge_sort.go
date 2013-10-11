package main

import (
  "fmt"
  "os"
  "bufio"
  "strconv"
)

func mergeSort(list *[]int) {
    x := *list
  if len(x) > 1 {
    mid := len(x)/2
    fmt.Println(mid)
    left := x[0:mid]
    right := x[mid:]
    mergeSort(&left)
    mergeSort(&right)
  }
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
  fmt.Println(ints, err)
  mergeSort(&ints)
  fmt.Println(ints, err)
}
