print "What is your name? "

if (name = gets).presence
  puts "Your name is: '#{name}'"
else
  puts
  puts "No name supplied"
end
