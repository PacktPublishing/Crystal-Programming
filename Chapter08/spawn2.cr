idx = 0

while idx < 4
  spawn do
    puts idx
  end
  
  idx += 1
end

Fiber.yield
