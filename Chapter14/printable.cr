annotation Print; end

record PrintData(IvarType, ClassType),
  name : String,
  value : IvarType,
  format : String = "%F",
  scale : Int32 = 2 do
  def type : IvarType.class
    IvarType
  end

  def class : ClassType.class
    ClassType
  end
end

module Printable
  def printable_properties
    {{
      @type.instance_vars.select(&.annotation Print).map do |ivar|
        "PrintData(#{ivar.type}, #{@type}).new(
           name: #{ivar.name.stringify},
           value: @#{ivar.name.id},
           #{ivar.annotation(Print).named_args.double_splat}
        )".id
      end
    }}
  end
end

class Printer
  def print(obj : Printable)
    string = String.build do |io|
      obj.printable_properties.each do |prop|
        case value = prop.value
        when Time  then value.to_s(io, prop.format)
        when Float then value.format(io, decimal_places: prop.scale)
        else
          value.to_s io
        end

        io.puts
      end
    end

    puts string
  end

  def print(obj)
    puts obj
  end
end

class MyClass
  include Printable

  @[Print]
  property name : String = "Jim"

  @[Print(format: "%F %T")]
  property created_at : Time = Time.utc
end

class NonPrintableClass
  property name : String = "Jim"
  property created_at : Time = Time.utc
end

my_class = MyClass.new
non_printable_class = NonPrintableClass.new

printer = Printer.new

printer.print my_class
printer.print non_printable_class
