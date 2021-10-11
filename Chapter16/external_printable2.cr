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

my_class = MyClass.new

class Printer
  def print(obj : Printable)
    string = String.build do |io|
      obj.class.print_metadata.printable_properties.each_value do |prop|
        prop.value(obj).to_s io

        io.puts
      end
    end

    puts string
  end

  def print(obj)
    puts obj
  end
end

Printer.new.print my_class
