class Blog::Models::User
  include DB::Serializable
  include AVD::Validatable
  include JSON::Serializable

  getter! id : Int64

  @[Assert::NotBlank]
  property first_name : String

  @[Assert::NotBlank]
  property last_name : String

  @[Assert::NotBlank]
  @[Assert::Email(:html5)]
  property email : String

  @[Assert::Size(8..25, min_message: "Your password is too short", max_message: "Your password is too long")]
  property password : String

  getter! created_at : Time
  getter! updated_at : Time

  getter deleted_at : Time?
end
# before_save :hash_password
# def hash_password : Nil
#   if p = @password
#     @password = Crypto::Bcrypt::Password.create(p).to_s
#   end
# end

# def generate_jwt : String
#   JWT.encode({
#     "user_id" => @id,
#     "exp"     => (Time.utc + 1.week).to_unix,
#     "iat"     => Time.utc.to_unix,
#   },
#     ENV["SECRET"],
#     :hs512
#   )
# end
