require "yaml"
require "json"

module Transform::YAML
  def self.deserialize(input : String) : String
    ::YAML.parse(input).to_json
  end

  def self.serialize(input : String) : String
    JSON.parse(input).to_yaml
  end
end
