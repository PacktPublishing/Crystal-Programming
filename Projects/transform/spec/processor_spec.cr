require "./spec_helper"

private class MockNotificationEmitter < Transform::NotificationEmitter
  getter emitted_notifications = [] of Transform::Notification

  def emit(notification : Transform::Notification) : Nil
    @emitted_notifications << notification
  end
end

private def assert_process(
  filter : String,
  input_data : String,
  expected_output : String,
  & : Array(Transform::Notification) -> Nil
) : Nil
  mock_emitter = MockNotificationEmitter.new
  input = IO::Memory.new input_data
  output = IO::Memory.new
  Transform::Processor.new(mock_emitter).process [filter], input, output, IO::Memory.new
  output.to_s.should eq expected_output
  yield mock_emitter.emitted_notifications
end

describe Transform::Processor do
  describe "#process" do
    it "scalar transformation" do
      assert_process ". * 10", %(5), "--- 50\n" { |notifications| notifications.should be_empty }
    end

    it "object transformation" do
      assert_process(
        %({"name": (.first_name + " " + .last_name)}),
        %({"first_name":"George","last_name":"Dietrich"}),
        %(---\nname: George Dietrich\n)
      ) { |notifications| notifications.should be_empty }
    end

    it "error state" do
      expect_raises YAML::ParseException, "unexpected end of stream" do
        assert_process ".", %({"foo":"a}), "" do |notifications|
          notifications.size.should eq 1
          notifications[0].summary.should eq "Oh no!"
          notifications[0].body.should contain "unexpected end of stream"
        end
      end
    end
  end
end
