package main

import (
	"fmt"
)

func selectionSort(arr []int) {
	var n = len(arr)

	// For each element index...
	for i := 0; i < n; i++ {
		// Find the smallest element after it
		var min = i
		for j := i + 1; j < n; j++ {
			if arr[j] < arr[min] {
				min = j
			}
		}

		// Swap positions with the smallest element
		arr[i], arr[min] = arr[min], arr[i]
	}
}

func main() {
	// Produce a reversed list of 30k elements
	n := 30000
	list := make([]int, n, n)
	for i := 0; i < n; i++ {
		list[i] = n - i
	}

	// Sort it and then print its head and tail
	selectionSort(list)
	fmt.Println(list[0:10])
	fmt.Println(list[n-10:])
}
