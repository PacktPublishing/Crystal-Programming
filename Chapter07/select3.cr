spawn_receiver = true

channel = Channel(Int32).new

if spawn_receiver
  spawn do
    puts "Received: #{channel.receive}"
  end
end

spawn do
  select
  when channel.send 10
    puts "sent value"
  else
    puts "skipped sending value"
  end
end

Fiber.yield
