class Transform::NotificationEmitter
  @@initialized : Bool = false

  at_exit { LibNotify.notify_uninit }

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
