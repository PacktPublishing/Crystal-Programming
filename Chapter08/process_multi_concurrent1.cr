class Transform::Processor
  def process_multiple(filter : String, input_files : Array(String), error : IO) : Nil
    channel = Channel(Bool).new

    input_files.each do |file|
      spawn do
        File.open(file, "r") do |input_file|
          File.open("#{input_file.path}.transformed", "w") do |output_file|
            self.process [filter], input_file, output_file, error
          end
        end
      ensure
        channel.send true
      end
    end

    input_files.size.times do
      channel.receive
    end
  end
end
