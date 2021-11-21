abstract class Animal
end

class Cat < Animal
end

class Dog < Animal
end

class Food(T)
  def self.new
    {% raise "Non animal '#{T}' cannot be fed." unless T <= Animal %}
  end
end

Food(Cat).new
Food(Dog).new
Food(Int32).new
