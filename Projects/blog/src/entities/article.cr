class Blog::Entities::Article
  include DB::Serializable
  include ASR::Serializable
  include AVD::Validatable

  def initialize(@title : String, @body : String); end

  @[ASRA::ReadOnly]
  getter! id : Int64?

  @[ASRA::ReadOnly]
  property! author_id : Int64

  @[Assert::NotBlank]
  property title : String

  @[Assert::NotBlank]
  property body : String

  @[ASRA::ReadOnly]
  getter! updated_at : Time

  @[ASRA::ReadOnly]
  getter! created_at : Time

  @[ASRA::ReadOnly]
  getter deleted_at : Time?

  protected def after_save(@id : Int64) : Nil; end

  protected def before_save : Nil
    if @id.nil?
      @created_at = Time.utc
    end

    @updated_at = Time.utc
  end

  protected def on_remove : Nil
    @deleted_at = Time.utc
  end
end
