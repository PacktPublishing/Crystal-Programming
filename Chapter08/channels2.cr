channel = Channel(Int32).new

spawn do
  loop do
    puts "Waiting"

    sleep 0.5
  end
end

spawn do
  sleep 2

  channel.send channel.receive * 2

  sleep 1

  channel.send channel.receive * 3
end

channel.send 2

puts channel.receive

channel.send 3

puts channel.receive
