module SomeInterface; end

class Bar
  include SomeInterface
end

class Foo; end

class Baz
  include SomeInterface
end

class Biz < Baz; end

{{pp SomeInterface.includers}}

{{pp Biz.ancestors}}
