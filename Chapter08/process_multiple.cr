def process_multiple(input_args : Array(String), input : IO, output : IO, error : IO) : Nil
  filter = input_args.shift

  channel = Channel(Bool | Exception).new

  input_args.each do |file|
    spawn do
      File.open(file, "r") do |input_file|
        File.open("#{input_file.path}.transformed", "w") do |output_file|
          self.process [filter], input_file, output_file, error
        end
      end

      channel.send true
    rescue ex : Exception
      channel.send ex
    end
  end

  input_args.size.times do
    case v = channel.receive
    in Exception then raise v
    in Bool
      # Skip
    end
  end
rescue ex : Exception
  if message = ex.message
    @emitter.emit "Oh no!", message
  end

  raise ex
end
