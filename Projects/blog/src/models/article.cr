class Blog::Models::Article
  include JSON::Serializable
  include AVD::Validatable

  getter! id : Int64?

  def initialize(@title : String, @body : String); end

  @[Assert::NotBlank]
  property title : String

  @[Assert::NotBlank]
  property body : String

  getter! updated_at : Time
  getter! created_at : Time
  getter deleted_at : Time?
end
