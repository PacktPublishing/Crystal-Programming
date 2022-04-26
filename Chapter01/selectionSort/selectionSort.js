function selectionSort(arr) {
  const n = arr.length;

  // For each element index...
  for (let i = 0; i < n; i++) {
    // Find the smallest element after it
    let min = i;
    for (let j = i + 1; j < n; j++) if (arr[j] < arr[min]) min = j;

    // Swap positions with the smallest element
    const temp = arr[min];
    arr[min] = arr[i];
    arr[i] = temp;
  }
}

// Produce a reversed list of 30k elements
const n = 30000;
const arr = new Array(n);
for (let i = 0; i < n; i++) {
  arr[i] = n - i;
}

selectionSort(arr, n);
console.log(arr.slice(0, 10));
console.log(arr.slice(n - 10, n));
