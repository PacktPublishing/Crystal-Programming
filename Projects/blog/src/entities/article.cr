class Blog::Entities::Article
  include DB::Serializable
  include JSON::Serializable
  include AVD::Validatable

  def initialize(@title : String, @body : String); end

  getter! id : Int64?

  property! author_id : Int64

  @[Assert::NotBlank]
  property title : String

  @[Assert::NotBlank]
  property body : String

  getter! updated_at : Time
  getter! created_at : Time
  getter deleted_at : Time?

  protected def after_save(@id : Int64) : Nil; end

  protected def before_save : Nil
    if @id.nil?
      @created_at = Time.utc
    end

    @updated_at = Time.utc
  end
end
