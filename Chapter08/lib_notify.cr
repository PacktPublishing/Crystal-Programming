@[Link("libnotify")]
lib LibNotify
  alias GInt = LibC::Int
  alias GBool = GInt
  alias GChar = LibC::Char

  struct InternalNotifyNotification
    parent_object : Void*
    priv : Void*
  end

  type NotifyNotification = InternalNotifyNotification

  fun notify_init(app_name : LibC::Char*) : GBool
  fun notify_uninit : Void

  fun notify_notification_new(summary : GChar*, body : GChar*, icon : GChar*) : NotifyNotification*
  fun notify_notification_show(notification : NotifyNotification*, error : Void**) : GBool
  fun notify_notification_update(notification : NotifyNotification*, summary : GChar*, body : GChar*, icon : GChar*) : GBool
end
