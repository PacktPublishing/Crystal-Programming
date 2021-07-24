class Transform::Processor
  def process_multiple(input_args : Array(String) = ARGV, input : IO = ARGF, output : IO = STDOUT, error : IO = STDERR) : Nil
    filter = input_args.shift

    channel = Channel(Bool).new

    input_args.each do |file|
      spawn do
        File.open(file, "r") do |input_file|
          File.open("#{input_file.path}.transformed", "w") do |output_file|
            self.process [filter], input_file, output_file
          end
        end

        channel.send true
      end
    end

    input_args.size.times do
      channel.receive
    end
  end
end
