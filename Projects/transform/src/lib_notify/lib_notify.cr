require "./notification"
require "./notification_emitter"

@[Link("libnotify")]
lib LibNotify
  alias GInt = LibC::Int
  alias GBool = GInt
  alias GChar = LibC::Char

  type NotifyNotification = Void*

  fun notify_init(app_name : LibC::Char*) : GBool
  fun notify_uninit : Void

  fun notify_notification_new(summary : GChar*, body : GChar*, icon : GChar*) : NotifyNotification*
  fun notify_notification_show(notification : NotifyNotification*, error : Void**) : GBool
  fun notify_notification_update(notification : NotifyNotification*, summary : GChar*, body : GChar*, icon : GChar*) : GBool
end
