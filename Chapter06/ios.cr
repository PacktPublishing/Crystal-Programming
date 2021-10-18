io = IO::Memory.new

io << "Hello"
io << " " << "World!"

puts io

string = String.build do |io|
  io << "Goodbye"
  io << " " << "World"
end

puts string
