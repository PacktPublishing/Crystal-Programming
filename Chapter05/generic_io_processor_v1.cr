class Transform::Processor
  def process(input_args : Array(String) = ARGV, input : IO = ARGF, output : IO = STDOUT, error : IO = STDERR) : Nil
    filter = input_args.shift
    input = input.gets_to_end

    output_data = String.build do |str|
      run = Process.run(
        "jq",
        [filter],
        input: IO::Memory.new(
          Transform::YAML.deserialize input
        ),
        output: str,
        error: error
      )

      exit 1 unless run.success?
    end

    output.puts Transform::YAML.serialize output_data
  end
end
