module TransformerInterface
  abstract def transform(value : String) : String
end

struct ShoutTransformer
  include TransformerInterface

  def transform(value : String) : String
    value.upcase
  end
end

class Processor
  def initialize(@transformer : TransformerInterface = ShoutTransformer.new); end

  def process(value : String) : Nil
    @transformer.transform value
  end
end

puts Processor.new.process "foo"

class MockTransformer
  include TransformerInterface

  getter transformed_value : String? = nil

  def transform(value : String) : String
    @transformed_value = value
  end
end

require "spec"

describe Processor do
  describe "#process" do
    it "processes" do
      transformer = MockTransformer.new
      Processor.new(transformer).process "bar"
      transformer.transformed_value.should eq "bar"
    end
  end
end
