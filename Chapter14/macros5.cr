macro def_macros(*numbers)
  {% for num, idx in numbers %}
    macro def_num_{{idx}}_methods(n)
      \{% idx = {{idx}} %}

      {% verbatim do %}
        def num_{{n}}
          {{n}}
        end
        
        def num_{{n}}_index
          {{idx}}
        end
      {% end %}
    end

    def_num_{{idx}}_methods({{num}})
    {{debug}}
  {% end %}
end

def_macros 2, 1

pp num_1_index # => 1
pp num_2_index # => 0
