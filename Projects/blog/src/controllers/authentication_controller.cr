class Blog::Controllers::Authentication < ATH::Controller
  @[ATHA::Post("/login")]
  @[ATHA::RequestParam("username", requirements: @[Assert::NotBlank])]
  @[ATHA::RequestParam("password", requirements: @[Assert::NotBlank])]
  def login(username : String, password : String) : NamedTuple(token: String)
    # TODO: Use credentials to lookup/verify the user.

    {
      token: JWT.encode({
        "user_id" => 1,
        "exp"     => (Time.utc + 1.week).to_unix,
        "iat"     => Time.utc.to_unix,
      },
        ENV["SECRET"],
        :hs512
      ),
    }
  end
end
