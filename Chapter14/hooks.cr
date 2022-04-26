require "spec"

Spec.before_suite do
  ENV["GLOBAL_VAR"] = "foo"
end

describe "My tests" do
  it "parent1" do
    puts "parent test 1: #{ENV["GLOBAL_VAR"]?} - #{ENV["SUB_VAR"]?}"
  end

  describe "sub tests" do
    # around_each do
    #   ENV["SUB_VAR"] = "bar"
    # end

    # after_each do
    #   ENV.delete "SUB_VAR"
    # end

    around_each do |example|
      ENV["SUB_VAR"] = "bar"
      example.run
      ENV.delete "SUB_VAR"
    end

    it "child1" do
      puts "child test: #{ENV["GLOBAL_VAR"]?} - #{ENV["SUB_VAR"]?}"
    end
  end

  it "parent2" do
    puts "parent test 2: #{ENV["GLOBAL_VAR"]?} - #{ENV["SUB_VAR"]?}"
  end
end
