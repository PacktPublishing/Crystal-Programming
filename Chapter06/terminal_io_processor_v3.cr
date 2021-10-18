class Transform::Processor
  def process : Nil
    filter = ARGV.shift
    input = ARGF.gets_to_end

    output_data = String.build do |str|
      run = Process.run(
        "jq",
        [filter],
        input: IO::Memory.new(
          Transform::YAML.deserialize input
        ),
        output: str,
        error: STDERR
      )

      exit 1 unless run.success?
    end

    STDOUT.puts Transform::YAML.serialize output_data
  end
end
