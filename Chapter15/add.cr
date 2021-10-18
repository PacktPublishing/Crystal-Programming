def add(value1, value2)
  value1 + value2
end

require "spec"

describe "#add" do
  it "adds with positive values" do
    add(1, 2).should eq 3
  end

  it "adds with negative values" do
    add(-1, -2).should eq -3
  end

  it "adds with mixed signed values" do
    add(-1, 2).should eq 1
  end
end
