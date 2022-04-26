def selectionSort(arr):
  # For each element index...
  for i in range(len(arr)):
    # Find the smallest element after it
    min = i
    for j in range(i+1, len(arr)):
        if arr[min] > arr[j]:
            min = j

    # Swap positions with the smallest element
    arr[i], arr[min] = arr[min], arr[i]

arr = [*range(1, 30001)]
arr.reverse()

selectionSort(arr)
print(arr[0:10])
print(arr[-10:])
