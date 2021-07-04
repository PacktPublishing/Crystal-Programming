class Transform::Processor
  def process(input_args : Array(String) = ARGV, input : IO = ARGF, output : IO = STDOUT, error : IO = STDERR) : Nil
    filter = input_args.shift

    input_buffer = IO::Memory.new
    output_buffer = IO::Memory.new

    Transform::YAML.deserialize input, input_buffer
    input_buffer.rewind

    run = Process.run(
      "jq",
      [filter],
      input: input_buffer,
      output: output_buffer,
      error: error
    )

    exit 1 unless run.success?

    output_buffer.rewind
    Transform::YAML.serialize output_buffer, output
  end
end
