class Blog::Entities::User
  include DB::Serializable
  include AVD::Validatable
  include JSON::Serializable

  getter! id : Int64

  def initialize(@first_name : String, @last_name : String, @email : String, @password : String); end

  @[Assert::NotBlank]
  property first_name : String

  @[Assert::NotBlank]
  property last_name : String

  @[Assert::NotBlank]
  @[Assert::Email(:html5)]
  property email : String

  @[Assert::Size(8..25, min_message: "Your password is too short", max_message: "Your password is too long")]
  @[JSON::Field(ignore_serialize: true)]
  property password : String

  getter! created_at : Time
  getter! updated_at : Time

  getter deleted_at : Time?

  protected def after_save(@id : Int64) : Nil; end

  protected def before_save : Nil
    if @id.nil?
      @created_at = Time.utc
      @password = Crypto::Bcrypt::Password.create(@password).to_s
    end

    @updated_at = Time.utc
  end

  protected def on_remove : Nil
    @deleted_at = Time.utc
  end
end
