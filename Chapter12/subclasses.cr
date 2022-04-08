abstract class Vehicle; end

abstract class Car < Vehicle; end

class SUV < Vehicle; end

class Sedan < Car; end

class Van < Car; end

{{pp Vehicle.subclasses}}
{{pp Vehicle.all_subclasses}}

{% for type in Vehicle.all_subclasses.reject &.abstract? %}
  pp {{type}}.new
{% end %}
