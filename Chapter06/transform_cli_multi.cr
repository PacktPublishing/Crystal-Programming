require "./transform"
require "option_parser"

processor = Transform::Processor.new

multi_file_mode = false

OptionParser.parse do |parser|
  parser.banner = "Usage: transform <filter> [options] [arguments] [filename]"
  parser.on("-m", "--multi", "Enables multiple file input mode") { multi_file_mode = true }
  parser.on("-h", "--help", "Show this help") do
    puts parser
    exit
  end
end

begin
  if multi_file_mode
    processor.process_multiple
  else
    processor.process
  end
rescue ex : RuntimeError
  exit 1
end
