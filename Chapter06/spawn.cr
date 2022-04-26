puts "Hello program!"

spawn do
  puts "Hello from fiber!"
end

Fiber.yield

puts "Goodbye program!"
