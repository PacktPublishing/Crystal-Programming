module Foo
  macro included
    {{pp @type.has_method? "run"}}
  end
end

module Bar
  def run; end

  macro included
    {{pp @type.has_method? "run"}}
  end
end

class MyClass
  include Foo
  include Bar
end

MyClass.new
