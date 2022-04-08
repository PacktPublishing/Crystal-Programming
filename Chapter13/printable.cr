annotation Print
end

module Printable
  def print(printer)
    printer.start
    {% for ivar in @type.instance_vars.select(&.annotation Print) %}
      printer.ivar({{ivar.name.stringify}}, @{{ivar.name.id}}, {{ivar.annotation(Print).named_args.double_splat}})
    {% end %}
    printer.finish
  end

  def print(io : IO = STDOUT)
    print IOPrinter.new(io)
  end
end

struct IOPrinter
  def initialize(@io : IO); end

  def start
    @io.puts "---"
  end

  def finish
    @io.puts "---"
    @io.puts
  end

  def ivar(name : String, value : String)
    @io << name << ": " << value
    @io.puts
  end

  def ivar(name : String, value : Float32, *, scale : Int32 = 3)
    @io << name << ": "
    value.format(@io, decimal_places: scale)
    @io.puts
  end

  def ivar(name : String, value : Time, *, format : String = "%Y-%m-%d %H:%M:%S %:z")
    @io << name << ": "
    value.to_s(@io, format)
    @io.puts
  end
end

class MyClass
  include Printable

  @[Print]
  property name : String = "Jim"

  @[Print(format: "%F")]
  property created_at : Time = Time.utc

  @[Print(scale: 1)]
  property weight : Float32 = 56.789
end

MyClass.new.print
# ---
# name: Jim
# created_at: 2021-11-16
# weight: 56.8
# ---
