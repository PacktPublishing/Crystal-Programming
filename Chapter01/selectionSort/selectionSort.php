<?php

function selectionSort(&$arr) {
  $n = count($arr);

  // For each element index...
  for ($i = 0; $i < $n; $i++) {
    // Find the smallest element after it
    $min = $i;
    for ($j = $i + 1; $j < $n; $j++)
      if ($arr[$j] < $arr[$min])
        $min = $j;

    // Swap positions with the smallest element
    $temp = $arr[$min];
    $arr[$min] = $arr[$i];
    $arr[$i] = $temp;
  }
}

// Produce a reversed list of 30k elements
$n = 30000;
$arr = array_reverse(range(1, $n));
selectionSort($arr, $n);
print_r(array_slice($arr, 0, 10));
print_r(array_slice($arr, $n - 10, $n));
