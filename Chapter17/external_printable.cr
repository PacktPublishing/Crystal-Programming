annotation Print; end

abstract struct PrintDataBase; end

record PrintData(ClassType) < PrintDataBase,
  name : String do
  def class_name : ClassType.class
    ClassType
  end
end

annotation PrintConfig; end

class PrintableMetadata(T)
  def initialize
    {{@type}}

    {% begin %}
      @printable_properties = {
        {% for ivar in T.instance_vars.select(&.annotation Print) %}
          {{ivar.name.stringify}} => PrintData(T).new({{ivar.name.stringify}}),
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

pp MyClass.print_metadata
