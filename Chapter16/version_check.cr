module MyShard
  VERSION = "45.0.0"
end

{% if compare_versions(MyShard::VERSION, "2.0.0") >= 0 %}
  puts "greater than or equal to 2.0.0"
{% else %}
  puts "less than 2.0.0"
{% end %}
