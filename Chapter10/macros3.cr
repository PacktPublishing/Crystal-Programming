macro def_methods(*numbers, only_odd = false)
  {% for num, idx in numbers %}
    {% if !only_odd || (num % 2) != 0 %}
      # Returns the number at index {{idx}}.
      def {{"number_#{idx}".id}}
        {{num}}
      end
    {% end %}
  {% end %}
  {{debug}}
end

def_methods 1, 3, 6, only_odd: true

pp number_0
pp number_1
