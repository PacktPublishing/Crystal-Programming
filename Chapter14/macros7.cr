class Foo
  def hello(one : Int32, two, there, four : Bool, five : String?)
    {% begin %}
      pp {{"#{@def.name} has #{@def.args.size} arguments"}}
      pp {% typed_arguments = @def.args.select(&.restriction) %}
      pp {{"with #{typed_arguments.size} typed arguments"}}
      pp {{"and is a #{@def.visibility.id} method"}}
    {% end %}
  end
end

Foo.new.hello 1, 2, 3, false, nil
