MODELS = [] of ModelBase.class

macro register_model(type)
  {% MODELS << type.resolve %}
end

abstract class ModelBase
end

class Cat < ModelBase
end

class Dog < ModelBase
end

def model_by_name(name)
  {% begin %}
    case name
    {% for model in MODELS %}
      when {{model.name.stringify}} then {{model}}
    {% end %}
    else
      raise "model unknown"
    end
  {% end %}
end

pp {{ MODELS }}
pp model_by_name "Cat"

register_model Cat
register_model Dog

pp {{ MODELS }}
pp model_by_name "Cat"
