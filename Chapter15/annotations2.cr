annotation MyClass
end

annotation MyMethod
end

@[MyClass(true, id: "foo_class")]
class Foo
  {% begin %}
    {% ann = @type.annotation MyClass %}
    {% pp "#{@type} has positional arguments of: #{ann.args}" %}
    {% pp "and named arguments of #{ann.named_args}" %}
    {% pp %(and is #{ann[0] ? "active".id : "not active".id}) %}
  {% end %}
end

@[MyMethod(4, 1, 2, id: "foo")]
def my_method
  {% begin %}
    {% ann = @def.annotation MyMethod %}
    {% puts "\n" %}
    {% pp "Method #{@def.name} has an id of #{ann[:id]}" %}
    {% pp "and has #{ann.args.size} positional arguments" %}
    {% total = ann.args.reduce(0) { |acc, v| acc + v } %}
    {% pp "that sum to #{total}" %}
  {% end %}
end

my_method
