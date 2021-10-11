require "./spec_helper"

private def assert_deserialization(input_data : String, expected_output : String) : Nil
  it "deserializes #{input_data.inspect}" do
    input = IO::Memory.new input_data
    output = IO::Memory.new
    Transform::YAML.deserialize input, output
    output.to_s.should eq expected_output
  end
end

describe Transform::YAML do
  describe ".deserialize" do
    assert_deserialization %(---\n10), "10"
    assert_deserialization %(---\nfoo: bar\nage: 10), %({"foo":"bar","age":10})
  end
end
