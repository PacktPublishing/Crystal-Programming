abstract class Foo
  def foo; end
end

module Bar
  def bar; end
end

class Baz < Foo
  include Bar

  def baz; end
end

{{pp Baz.methods.map &.name}}
