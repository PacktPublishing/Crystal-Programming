@[ADI::Register(public: true)]
class Blog::Controllers::Authentication < ATH::Controller
  def initialize(@entity_manager : Blog::Services::EntityManager); end

  @[ATHA::Post("/login")]
  @[ATHA::RequestParam("username", requirements: @[Assert::NotBlank])]
  @[ATHA::RequestParam("password", requirements: @[Assert::NotBlank])]
  def login(username : String, password : String) : NamedTuple(token: String)
    user = @entity_manager
      .repository(Blog::Entities::User)
      .find_by_username? username

    if user.nil? || !(Crypto::Bcrypt::Password.new(user.password).verify password)
      raise ATH::Exceptions::Unauthorized.new "Invalid username and/or password.", "Basic realm=\"My Blog\""
    end

    {
      token: JWT.encode({
        "user_id" => user.id,
        "exp"     => (Time.utc + 1.week).to_unix,
        "iat"     => Time.utc.to_unix,
      },
        ENV["SECRET"],
        :hs512
      ),
    }
  end

  @[ATHA::Post("/register")]
  @[ATHA::ParamConverter("user", converter: ATH::RequestBodyConverter)]
  def register(user : Blog::Entities::User) : Blog::Entities::User
    @entity_manager.persist user
    user
  end
end
