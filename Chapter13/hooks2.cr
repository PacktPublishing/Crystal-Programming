module MyModule
  module ClassMethods
    def foo
      "foo"
    end
  end

  macro included
    extend ClassMethods
  end

  def bar
    "bar"
  end
end

class Foo
  include MyModule
end

pp Foo.foo
pp Foo.new.bar
