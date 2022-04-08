class Transform::Processor
  def process(input : String) : String
    output_data = String.build do |str|
      Process.run(
        "jq",
        [%([.[] | {"id": (.id + 1), "name": .author.name}])],
        input: IO::Memory.new(
          Transform::YAML.deserialize input
        ),
        output: str
      )
    end

    Transform::YAML.serialize output_data
  end
end
