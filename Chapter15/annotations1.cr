annotation MyAnnotation; end

@[MyAnnotation]
class MyClass
  def foo
    {{pp @type.annotation MyAnnotation}}
    {{pp @def.annotation MyAnnotation}}
  end
end

MyClass.new.foo
