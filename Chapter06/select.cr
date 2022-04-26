channel1 = Channel(Int32).new
channel2 = Channel(Int32).new

spawn do
  puts "Starting fiber 1"
  sleep 3
  channel1.send 1
end

spawn do
  puts "Starting fiber 2"
  sleep 1
  channel2.send 2
end

select
when v = channel1.receive
  puts "Received #{v} from channel1"
when v = channel2.receive
  puts "Received #{v} from channel2"
end
