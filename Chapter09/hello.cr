@[Link(ldflags: "#{__DIR__}/hello.o")]
lib LibHello
  fun say_hello = sayHello(name : LibC::Char*) : Void
end

LibHello.say_hello "Bob"
