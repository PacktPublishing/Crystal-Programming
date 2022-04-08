def spawn_and_puts(value)
  spawn do
    puts value
  end
end

idx = 0

while idx < 4
  spawn_and_puts idx

  idx += 1
end

Fiber.yield
