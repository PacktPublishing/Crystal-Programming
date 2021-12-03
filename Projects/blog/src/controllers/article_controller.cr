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

  @[ATHA::Put("/article")]
  @[ATHA::ParamConverter("article", converter: ATH::RequestBodyConverter)]
  def update_article(article : Blog::Entities::Article) : Blog::Entities::Article
    @entity_manager.persist article
    article
  end

  @[ATHA::Get("/article/:id")]
  @[ATHA::ParamConverter("article", converter: Blog::Converters::Database)]
  def article(article : Blog::Entities::Article) : Blog::Entities::Article
    article
  end

  @[ATHA::Delete("/article/:id")]
  @[ATHA::ParamConverter("article", converter: Blog::Converters::Database)]
  def delete_article(article : Blog::Entities::Article) : Nil
    @entity_manager.remove article
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
