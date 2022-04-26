class Transform::Processor
  def process(input_args : Array(String) = ARGV, input : IO = ARGF, output : IO = STDOUT, error : IO = STDERR) : Nil
    filter = input_args.shift

    input_read, input_write = IO.pipe
    output_read, output_write = IO.pipe

    Transform::YAML.deserialize input, input_write
    input_write.close

    run = Process.run(
      "jq",
      [filter],
      input: input_read,
      output: output_write,
      error: error
    )

    output_write.close

    raise RuntimeError.new unless run.success?

    Transform::YAML.serialize output_read, output
  end
end
