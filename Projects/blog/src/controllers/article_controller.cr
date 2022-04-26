@[ADI::Register(public: true)]
class Blog::Controllers::ArticleController < ATH::Controller
  def initialize(
    @entity_manager : Blog::Services::EntityManager
  ); end

  @[ARTA::Post("/article")]
  @[ATHA::ParamConverter("article", converter: ATH::RequestBodyConverter)]
  def create_article(article : Blog::Entities::Article) : Blog::Entities::Article
    @entity_manager.persist article
    article
  end

  @[ARTA::Put("/article/{id}")]
  @[ATHA::ParamConverter("article_entity", converter: Blog::Converters::Database)]
  @[ATHA::ParamConverter("article", converter: ATH::RequestBodyConverter)]
  def update_article(article_entity : Blog::Entities::Article, article : Blog::Entities::Article) : Blog::Entities::Article
    article_entity.title = article.title
    article_entity.body = article.body

    @entity_manager.persist article_entity
    article_entity
  end

  @[ARTA::Get("/article/{id}")]
  @[ATHA::ParamConverter("article", converter: Blog::Converters::Database)]
  @[Blog::Annotations::Template("article.html.j2")]
  def article(article : Blog::Entities::Article) : Blog::Entities::Article
    article
  end

  @[ARTA::Get("/article")]
  def articles : Array(Blog::Entities::Article)
    @entity_manager.repository(Blog::Entities::Article).find_all
  end

  @[ARTA::Delete("/article/{id}")]
  @[ATHA::ParamConverter("article", converter: Blog::Converters::Database)]
  def delete_article(article : Blog::Entities::Article) : Nil
    @entity_manager.remove article
  end
end
