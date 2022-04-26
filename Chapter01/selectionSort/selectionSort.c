#include <stdio.h>
#include <stdlib.h>

void selectionSort(int arr[], int n) {
  // For each element index...
  for (int i = 0; i < n; i++) {
    // Find the smallest element after it
    int min = i;
    for (int j = i + 1; j < n; j++)
      if (arr[j] < arr[min])
        min = j;

    // Swap positions with the smallest element
    int temp = arr[min];
    arr[min] = arr[i];
    arr[i] = temp;
  }
}

// Helper to print an array
void printArray(int arr[], int n) {
  printf("[");
  for (int i = 0; i < n; i++) {
    printf("%d", arr[i]);
    if (i < n - 1)
      printf(", ");
  }
  printf("]\n");
}

int main() {
  // Produce a reversed list of 30k elements
  int n = 30000;
  int* list = malloc(sizeof(int) * n);
  for (int i = 0; i < n; ++i) {
    list[i] = n - i;
  }

  // Sort it and then print its head and tail
  selectionSort(list, n);
  printArray(list, 10);
  printArray(list + n - 10, 10);
  return 0;
}
