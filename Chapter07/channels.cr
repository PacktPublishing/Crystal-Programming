input_channel = Channel(Int32).new
output_channel = Channel(Int32).new

spawn do
  output_channel.send input_channel.receive * 2
end

input_channel.send 2

puts output_channel.receive
