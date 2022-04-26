abstract class Parent
  macro inherited
    puts "#{{{@type.name}}} inherited Parent"
  end
end

module MyModule
  macro included
    puts "#{{{@type.name}}} included MyModule"
  end

  macro extended
    puts "#{{{@type.name}}} extended MyModule"
  end
end

class Child < Parent
  include MyModule
  extend MyModule
end
