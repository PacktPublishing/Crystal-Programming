macro def_method(name)
  def {{name.id}}
    puts "Hi"
  end
end

def_method foo

foo