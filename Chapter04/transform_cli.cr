require "./transform"

INPUT_DATA = <<-YAML
---
- id: 1
  author:
    name: Jim
- id: 2
  author:
    name: Bob
YAML

puts Transform::Processor.new.process INPUT_DATA
