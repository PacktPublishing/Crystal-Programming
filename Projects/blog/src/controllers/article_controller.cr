class Blog::Controllers::ArticleController < ATH::Controller
  @[ATHA::Post("/article")]
  @[ATHA::ParamConverter("article", converter: ATH::RequestBodyConverter)]
  def create_post(article : Blog::Models::Article) : Blog::Models::Article
    article
  end
end
