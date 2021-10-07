record Metadata(IvarType, ClassType),
  name : String do
  def class : ClassType.class
    ClassType
  end

  def type : IvarType.class
    IvarType
  end
end

EXCLUDED_TYPES = [] of Nil

macro exclude_type(type)
  {% type.raise %(Expected argument to `exclude_type` to be `Path`, got `#{type.class_name.id}`.) unless type.is_a? Path %}
  {% EXCLUDED_TYPES << type.resolve %}
end

module ExposableMetadata
  def metadata
    {% begin %}
      {% types = [] of Nil %}

      {% for ivar in @type.instance_vars %}
        {% unless EXCLUDED_TYPES.any? &.<=(ivar.type) %}
          {% types << "Metadata(#{ivar.type}, #{@type}).new(#{ivar.name.stringify})".id %}
        {% end %}
      {% end %}

      {{types}}
    {% end %}
  end
end

class MyClass
  include ExposableMetadata

  property name : String = "Jim"
  property created_at : Time = Time.utc
end

exclude_type "Time"

my_class = MyClass.new

pp my_class.metadata
