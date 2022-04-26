macro def_getter_setter(decl)
  @{{decl}}
  
  def {{decl.var}} : {{decl.type}}
    @{{decl.var}}
  end
  
  def {{decl.var}}=(@{{decl.var}} : {{decl.type}})
  end
end

class Foo
  def_getter_setter name : String?
  def_getter_setter number : Int32 = 123
  property float : Float64 = 3.14
end

obj = Foo.new

pp obj.name
obj.name = "Bob"
pp obj.name

pp obj.number
pp obj.float
