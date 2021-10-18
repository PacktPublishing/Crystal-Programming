class Transform::Processor
  def process : Nil
    input = ARGF.gets_to_end

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

    STDOUT.puts Transform::YAML.serialize output_data
  end
end
