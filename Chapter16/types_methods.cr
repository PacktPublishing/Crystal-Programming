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

# However, generating code is not the only use case for wanting to iterate over types or methods. Another use case involves iterating over them in order to “validate” the definitions beyond what the Crystal compiler is doing. For example, say you wanted to enforce that all methods have a return type restriction, or that if a specific annotation is applied that it has the expected values of the proper type. This can be accomplished via manually raising compile time errors within
