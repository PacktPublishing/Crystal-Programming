class Transform::Processor
  def process(input_args : Array(String), input : IO, output : IO, error : IO) : Nil
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

    raise RuntimeError.new unless run.success?

    output_buffer.rewind
    Transform::YAML.serialize output_buffer, output
  end

  def process_multiple(filter : String, input_files : Array(String), error : IO) : Nil
    input_files.each do |file|
      File.open(file, "r") do |input_file|
        File.open("#{input_file.path}.transformed", "w") do |output_file|
          self.process [filter], input_file, output_file, error
        end
      end
    end
  end
end
