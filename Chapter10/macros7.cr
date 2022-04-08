class Foo
  def hello(one : Int32, two, there, four : Bool, five : String?)
    {% begin %}
      {% typed_arguments = @def.args.select(&.restriction) %}
      <<-TEXT
      {{"#{@def.name} has #{@def.args.size} arguments"}}
      {{"with #{typed_arguments.size} typed arguments"}}
      {{"and is a #{@def.visibility.id} method"}}
      TEXT
    {% end %}
  end
end

puts Foo.new.hello 1, 2, 3, false, nil
