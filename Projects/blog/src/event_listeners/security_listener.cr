@[ADI::Register]
class Blog::EventListeners::SecurityListener
  include AED::EventListenerInterface

  def initialize(
    @user_storage : Blog::Services::UserStorage,
    @entity_manager : Blog::Services::EntityManager
  ); end

  def self.subscribed_events : AED::SubscribedEvents
    AED::SubscribedEvents{
      ATH::Events::Request => 10,
    }
  end

  def call(event : ATH::Events::Request, _dispatcher : AED::EventDispatcherInterface) : Nil
    if "POST" == event.request.method && event.request.path.in? "/register", "/login"
      return
    end

    unless (auth_header = event.request.headers.get?("Authorization").try &.first) && auth_header.starts_with? "Bearer "
      raise ATH::Exceptions::Unauthorized.new "Missing bearer token", "Bearer realm=\"My Blog\""
    end

    token = auth_header.lchop "Bearer "

    begin
      body, _ = JWT.decode token, ENV["SECRET"], :hs512
    rescue decode_error : JWT::DecodeError
      raise ATH::Exceptions::Unauthorized.new "Invalid token", "Bearer realm=\"My Blog\""
    end

    @user_storage.user = @entity_manager
      .repository(Blog::Entities::User)
      .find body["user_id"].as_i64
  end
end
