require "yaml"
require "json"

module Transform::YAML
  def self.deserialize(input : IO, output : IO) : Nil
    ::YAML.parse(input).to_json output
  end

  def self.serialize(input : IO, output : IO) : Nil
    JSON.parse(input).to_yaml output
  end
end
