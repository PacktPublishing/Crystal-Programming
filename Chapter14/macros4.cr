{% begin %}
  {% hash = {"foo" => "bar", "biz" => "baz"} %}

  {% for key, value in hash %}
    puts "#{{{key}}}=#{{{value}}}"
  {% end %}
{% end %}

{% begin %}
  {% arr = [1, 2, 3] %}
  {% hash = {} of Nil => Nil %}

  {% arr.each { |v| hash[v] = v * 2 } %}

  puts({{hash}})
{% end %}
