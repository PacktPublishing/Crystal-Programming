abstract struct MetadataBase; end

record PropertyMetadata(ClassType, PropertyType, PropertyIdx) < MetadataBase,
  name : String,
  id : Int32,
  priority : Int32 = 0 do
  def class_name : ClassType.class
    ClassType
  end

  def type : PropertyType.class
    PropertyType
  end

  def value(obj : ClassType)
    {% begin %}
      obj.@{{ClassType.instance_vars[PropertyIdx].name.id}}
    {% end %}
  end

  def value(obj) : NoReturn
    raise "BUG: Invoked default value method."
  end
end

annotation Metadata; end

module Metadatable
  macro included
    class_property metadata : Hash(String, MetadataBase) do
      {% verbatim do %}
        {% begin %}
          {
            {% for ivar, idx in @type.instance_vars.select &.annotation Metadata %}
              {{ivar.name.stringify}} => (PropertyMetadata(
                {{@type}},
                {{ivar.type.resolve}},
                {{idx}}
              ).new(
                {{ivar.name.stringify}},
                {{ivar.annotation(Metadata).named_args.double_splat}}
              )),
            {% end %}
          } of String => MetadataBase
        {% end %}
      {% end %}
    end
  end
end

class MyClass
  include Metadatable

  @[Metadata(id: 1)]
  property name : String = "Jim"

  @[Metadata(id: 2, priority: 7)]
  property created_at : Time = Time.utc
  property weight : Float32 = 56.789
end

pp MyClass.metadata["created_at"]

my_class = MyClass.new

value = MyClass.metadata["name"].value my_class

pp value, typeof(value)
