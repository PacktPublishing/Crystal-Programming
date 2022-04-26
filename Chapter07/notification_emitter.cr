require "./lib_notify"
require "./notification"

class Transform::NotificationEmitter
  @@initialized : Bool = false

  at_exit { LibNotify.notify_uninit if @@initialized }

  def emit(summary : String, body : String) : Nil
    self.emit Transform::Notification.new summary, body
  end

  def emit(notification : Transform::Notification) : Nil
    self.init
    LibNotify.notify_notification_show notification, nil
  end

  private def init : Nil
    return if @@initialized
    LibNotify.notify_init "Transform"
    @@initialized = true
  end
end
