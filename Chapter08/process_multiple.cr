def process_multiple(filter : String, input_files : Array(String), error : IO) : Nil
  channel = Channel(Bool | Exception).new

  input_files.each do |file|
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

  input_files.size.times do
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
