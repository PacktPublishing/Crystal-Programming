class Example
  property age : Int32

  def initialize(@age : Int32); end
end

class Example
  @age : Int32

  def initialize(@age : Int32); end

  def age : Int32
    @age
  end

  def age=(@age : Int32); end
end
