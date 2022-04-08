class Foo
  def self.foo; end

  def self.bar; end
end

{{pp Foo.class.methods.map &.name}}
