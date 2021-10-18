annotation MyAnnotation; end

@[MyAnnotation("foo")]
@[MyAnnotation(123)]
@[MyAnnotation(123)]
def annotation_read
  {% for ann, idx in @def.annotations(MyAnnotation) %} 
    {% pp "Annotation #{idx} = #{ann[0].id}" %}
  {% end %}
end

annotation_read
