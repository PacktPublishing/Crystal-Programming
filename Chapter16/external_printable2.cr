annotation Print; end

abstract struct PrintDataBase; end

record PrintData(ClassType, PropertyIdx) < PrintDataBase,
  name : String do
  def class : ClassType.class
    ClassType
  end

  def value(obj : ClassType)
    {% begin %}
      obj.@{{ClassType.instance_vars[PropertyIdx].name.id}}
    {% end %}
  end
end

annotation PrintConfig; end

class PrintableMetadata(T)
  def initialize
    {{@type}}

    {% begin %}
      @printable_properties = {
        {% for ivar, idx in T.instance_vars %}
          {% if ivar.annotation Print %}
            {{ivar.name.stringify}} => PrintData(T, {{idx}}).new({{ivar.name.stringify}}),
          {% end %}
        {% end %}
      } of String => PrintDataBase

      @name = {{(ann = T.annotation(PrintConfig)) ? ann[:name] : T.name.stringify}}
    {% end %}
  end

  getter printable_properties : Hash(String, PrintDataBase)
  getter name : String
end

module Printable
  macro included
    class_getter print_metadata : PrintableMetadata(self) { PrintableMetadata(self).new }
  end
end

class MyClass
  include Printable

  @[Print]
  property name : String = "Jim"

  @[Print(format: "%F %T")]
  property created_at : Time = Time.utc
end

metadata = MyClass.print_metadata

my_class = MyClass.new

pp metadata.printable_properties["name"].value my_class
