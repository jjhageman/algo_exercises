package main

import (
  "fmt"
  "os"
  "bufio"
  "strconv"
	"runtime"
	"time"
)

var cnt int

func mergeAndCountSplitInv(left, right []int) (merged []int) {
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
      cnt += len(left[i:])
      merged = append(merged, right[j])
      j++
    }
  }
  return
}

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

func concurrentMergeSort(list []int, result chan []int) {
  if len(list) > 1 {
    mid := len(list)/2
    left := list[0:mid]
    right := list[mid:]

    c1 := make(chan []int)
    c2 := make(chan []int)

    go concurrentMergeSort(left, c1)
    go concurrentMergeSort(right, c2)

    lsort := <-c1
    rsort := <-c2
    result <- merge(lsort, rsort)
  } 
  result <- list
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
  file := "IntegerArray.txt"
  fmt.Printf("Importing data from '%s'\n", file)
  ints, err := readInts(file)
  if err != nil { panic(err) }

  fmt.Println("Starting sequential mergesort")
	runtime.GC()
	t2 := time.Now()
  mergeSort(ints)
	t3 := time.Now()
	fmt.Printf("total %v\n", t3.Sub(t2))

  fmt.Println("Starting concurrent mergesort")
  r := make(chan []int)
	runtime.GC()
	t0 := time.Now()
  go concurrentMergeSort(ints, r)
  <-r
  t1 := time.Now()
	fmt.Printf("total %v\n", t1.Sub(t0))
  fmt.Println(cnt)
}
