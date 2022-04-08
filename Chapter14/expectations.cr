require "spec"

it do
  true.should be_true
  nil.should be_nil
  10.should be >= 5
  "foo bar baz".should contain "bar"
  10.should_not eq 5

  expect_raises Exception, "Err" do
    raise "Err"
  end
end
