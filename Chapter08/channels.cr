channel = Channel(Int32).new

spawn do
  channel.send channel.receive * 2
end

channel.send 2

puts channel.receive
