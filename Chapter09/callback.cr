@[Link(ldflags: "#{__DIR__}/callback.o")]
lib LibCallback
  fun number_callback(callback : LibC::Int -> Void) : Void
end

LibCallback.number_callback ->(value) { puts "Generated: #{value}" }
