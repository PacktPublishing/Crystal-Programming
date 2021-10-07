class Foo
  getter id : Int32 = 1
  getter name : String = "Jim"
  getter? active : Bool = true

  def to_h
    {
      "id"     => @id,
      "name"   => @name,
      "active" => @active,
    }
  end
end

pp Foo.new.to_h
