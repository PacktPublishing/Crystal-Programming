def selection_sort(arr)
  # For each element index...
  arr.each_index do |i|
    # Find the smallest element after it
    min = (i...arr.size).min_by { |j| arr[j] }

    # Swap positions with the smallest element
    arr[i], arr[min] = arr[min], arr[i]
  end
end

# Produce a reversed list of 30k elements
list = (1..30000).to_a.reverse

# Sort it and then print its head and tail
selection_sort(list)
p list[0...10]
p list[-10..-1]
