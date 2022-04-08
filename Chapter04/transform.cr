module Transform
  VERSION = "0.1.0"

  # The same input data used in the example at the beginning of the chapter.
  INPUT_DATA = %([{"id":1,"author":{"name":"Jim"}},{"id":2,"author":{"name":"Bob"}}])

  Process.run(
    "jq",
    [%([.[] | {"id": (.id + 1), "name": .author.name}])],
    input: IO::Memory.new(INPUT_DATA),
    output: :inherit
  )
end
