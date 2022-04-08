channel1 = Channel(Int32).new
channel2 = Channel(Int32).new
channel3 = Channel(Int32).new

spawn do
  puts "Starting fiber 1"
  sleep 2
  channel1.send 1
end

spawn do
  puts "Starting fiber 2"
  sleep 1
  channel2.send 2
end

spawn do
  puts "Starting fiber 3"
  channel3.send 3
end

loop do
  select
  when v = channel1.receive
    puts "Received #{v} from channel1"
  when v = channel2.receive
    puts "Received #{v} from channel2"
  when v = channel3.receive
    puts "Received #{v} from channel3"
  when timeout 3.seconds
    puts "Nothing left to process, breaking out"
    break
  end
end
