@[ADI::Register(public: true)]
class Blog::Controllers::ArticleController < ATH::Controller
  def initialize(
    @entity_manager : Blog::Services::EntityManager,
    @user_storage : Blog::Services::UserStorage
  ); end

  @[ATHA::Post("/article")]
  @[ATHA::ParamConverter("article", converter: ATH::RequestBodyConverter)]
  def create_article(article : Blog::Entities::Article) : Blog::Entities::Article
    article.author_id = @user_storage.user.id
    @entity_manager.persist article
    article
  end

  @[ATHA::Get("/article/:id")]
  def article(id : Int64) : Blog::Entities::Article
    @entity_manager.repository(Blog::Entities::Article).find id
  rescue ex : DB::NoResultsError
    raise ATH::Exceptions::NotFound.new "An item with the provided ID could not be found.", cause: ex
  end

  @[ATHA::Get("/article")]
  def articles : Array(Blog::Entities::Article)
    @entity_manager.repository(Blog::Entities::Article).find_by_author @user_storage.user.id
  end

  @[ATHA::Get("/author/:id/article")]
  def articles_by_author(id : Int64) : Array(Blog::Entities::Article)
    @entity_manager.repository(Blog::Entities::Article).find_by_author id
  end
end
