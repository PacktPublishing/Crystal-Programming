abstract class Foo
  def foo; end
end

module Bar
  def bar; end
end

class Baz < Foo
  include Bar

  def baz; end

  def foo(value : Int32); end

  def foo(value : String); end

  def bar(x); end
end

baz = Baz.new
baz.bar 1
baz.bar false

{{pp Baz.methods.map &.name}}
