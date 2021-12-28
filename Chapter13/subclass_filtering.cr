annotation MyAnnotation; end

abstract class Parent; end

@[MyAnnotation(id: 456)]
class Child < Parent; end

@[MyAnnotation]
class Foo; end

@[MyAnnotation(id: 123)]
class Bar; end

class Baz; end

module Asdf; end

{% for type in Object.all_subclasses.select { |t| (ann = t.annotation(MyAnnotation)) && (ann[:id] == nil || ann[:id] % 2 == 0) } %}
  {{pp type}}
{% end %}
