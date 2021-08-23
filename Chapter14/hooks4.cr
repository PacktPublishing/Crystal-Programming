abstract class Parent
  macro inherited
    {% pp %(Outside finished: #{@type.has_method? "run"}) %}
    macro finished
      \{% pp %(Inside finished: #{@type.has_method? "run"}) %}
    end
  end
end

class Child < Parent
  def run
  end
end

Child.new
