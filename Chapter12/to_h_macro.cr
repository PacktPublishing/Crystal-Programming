class Foo
  getter id : Int32 = 1
  getter name : String = "Jim"
  getter? active : Bool = true

  def to_h
    {% begin %}
    {
      {% for ivar in @type.instance_vars %}
        {{ivar.stringify}} => @{{ivar}},
      {% end %}
    }
  {% end %}
  end
end

pp Foo.new.to_h
