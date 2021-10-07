macro fresh_vars_sample(*names)
  {% for name, index in names %}
    %name{index} = {{index}}
  {% end %}
  {{debug}}
end

fresh_vars_sample a, b, c
