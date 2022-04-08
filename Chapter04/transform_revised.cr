require "./yaml"

module Transform
  VERSION    = "0.1.0"
  INPUT_DATA = <<-YAML
  ---
  - id: 1
    author:
      name: Jim
  - id: 2
    author:
      name: Bob
  YAML

  output_data = String.build do |str|
    Process.run(
      "jq",
      [%([.[] | {"id": (.id + 1), "name": .author.name}])],
      input: IO::Memory.new(
        Transform::YAML.deserialize(INPUT_DATA)
      ),
      output: str
    )
  end

  puts Transform::YAML.serialize(output_data)
end
