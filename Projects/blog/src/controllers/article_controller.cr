@[ADI::Register(public: true)]
class Blog::Controllers::ArticleController < ATH::Controller
  def initialize(
    @entity_manager : Blog::Services::EntityManager,
    @user_storage : Blog::Services::UserStorage
  ); end

  @[ARTA::Post("/article")]
  @[ATHA::ParamConverter("article", converter: ATH::RequestBodyConverter)]
  def create_article(article : Blog::Entities::Article) : Blog::Entities::Article
    article.author_id = @user_storage.user.id
    @entity_manager.persist article
    article
  end

  @[ARTA::Put("/article")]
  @[ATHA::ParamConverter("article", converter: ATH::RequestBodyConverter)]
  def update_article(article : Blog::Entities::Article) : Blog::Entities::Article
    if article.author_id != @user_storage.user.id
      raise ATH::Exceptions::Forbidden.new "Cannot edit someone else's article."
    end

    @entity_manager.persist article
    article
  end

  @[ARTA::Get("/article/{id}")]
  @[ATHA::ParamConverter("article", converter: Blog::Converters::Database)]
  @[Blog::Annotations::Template("article.html.j2")]
  def article(article : Blog::Entities::Article) : Blog::Entities::Article
    article
  end

  @[ARTA::Delete("/article/{id}")]
  @[ATHA::ParamConverter("article", converter: Blog::Converters::Database)]
  def delete_article(article : Blog::Entities::Article) : Nil
    if article.author_id != @user_storage.user.id
      raise ATH::Exceptions::Forbidden.new "Cannot delete someone else's article."
    end

    @entity_manager.remove article
  end

  @[ARTA::Get("/article")]
  def articles : Array(Blog::Entities::Article)
    @entity_manager.repository(Blog::Entities::Article).find_by_author @user_storage.user.id
  end

  @[ARTA::Get("/author/{id}/article")]
  def articles_by_author(id : Int64) : Array(Blog::Entities::Article)
    @entity_manager.repository(Blog::Entities::Article).find_by_author id
  end
end
