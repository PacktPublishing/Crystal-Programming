class Transform::Notification
  @notification : LibNotify::NotifyNotification*

  getter summary : String
  getter body : String
  getter icon : String?

  def initialize(@summary : String, @body : String, @icon : String? = nil)
    @notification = LibNotify.notify_notification_new @summary, @body, @icon || ""
  end

  def summary=(@summary : String) : Nil
    self.update
  end

  def body=(@body : String) : Nil
    self.update
  end

  def icon=(@icon : String?) : Nil
    self.update
  end

  def to_unsafe : LibNotify::NotifyNotification*
    @notification
  end

  private def update : Nil
    LibNotify.notify_notification_update @notification, @summary, @body, @icon
  end
end
