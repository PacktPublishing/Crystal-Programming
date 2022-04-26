annotation MyAnnotation; end

abstract class Foo
  @[MyAnnotation]
  def foo; end
end

module Bar
  @[MyAnnotation]
  def bar; end
end

class Baz < Foo
  include Bar

  def baz; end
end

{% begin %}
  {% methods = [] of Nil %}
  
  {% for type in Object.all_subclasses %}
    {% for method in type.methods %}
      {% if method.annotation MyAnnotation %}
        {% methods << method %}
      {% end %}
    {% end %}
  {% end %}
  
  {{pp methods.map &.name}}
{% end %}
