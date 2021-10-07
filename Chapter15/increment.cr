module Incrementable
  annotation Increment; end

  @[Increment]
  @four : Int32 = 4

  def increment
    {% for ivar in @type.instance_vars.select &.annotation Increment %}
     @{{ivar}} += 1
   {% end %}
  end
end

class MyClass
  include Incrementable

  getter zero : Int32 = 0

  @[Incrementable::Increment]
  getter one : Int32 = 1

  getter two : Int32 = 2
  getter three : Int32 = 3
end

obj = MyClass.new

pp obj

obj.increment

pp obj
