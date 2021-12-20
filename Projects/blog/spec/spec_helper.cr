require "spec"
require "../src/blog"

require "athena/spec"

ASPEC.run_all

class Blog::Spec::MockUserRepository
  def find(id : Int64) : Blog::Entities::User
    user = Blog::Entities::User.new "FIRST", "LAST", "EMAIL", "PASSWORD"
    user.after_save id
    user
  end

  def find_by_username?(username : String) : Blog::Entities::User?
    Blog::Entities::User.new "FIRST", "LAST", username, "PASSWORD"
  end
end

class Blog::Spec::MockArticleRepository
  def find(id : Int64) : Blog::Entities::Article
    article = Blog::Entities::Article.new "TITLE", "BODY"
    article.after_save id
    article.before_save
    article
  end

  def find?(id : Int64) : Blog::Entities::Article?
    article = Blog::Entities::Article.new "TITLE", "BODY"
    article.after_save id
    article.before_save
    article
  end

  def find_by_author(user_id : Int64) : Array(Blog::Entities::Article)
    article = Blog::Entities::Article.new "TITLE", "BODY"
    article.before_save

    [article]
  end
end

class Blog::Spec::MockEntityManager < Blog::Services::EntityManager
  class_setter mock_user_repository : Blog::Spec::MockUserRepository? = nil
  class_setter mock_article_repository : Blog::Spec::MockArticleRepository? = nil

  getter persisted_entities : Array(DB::Serializable) = Array(DB::Serializable).new
  getter removed_entities : Array(DB::Serializable) = Array(DB::Serializable).new

  def repository(entity_class : Blog::Entities::User.class) : Blog::Spec::MockUserRepository
    @@mock_user_repository ||= Blog::Spec::MockUserRepository.new
  end

  def repository(entity_class : Blog::Entities::Article.class) : Blog::Spec::MockArticleRepository
    @@mock_article_repository ||= Blog::Spec::MockArticleRepository.new
  end

  def remove(entity : DB::Serializable) : Nil
    entity.on_remove if entity.responds_to? :on_remove
    @removed_entities << entity
  end

  def persist(entity : DB::Serializable) : Nil
    entity.before_save if entity.responds_to? :before_save
    @persisted_entities << entity
  end
end

class ADI::Spec::MockableServiceContainer
  getter(blog_services_entity_manager) { Blog::Spec::MockEntityManager.new }
end

abstract struct Blog::Spec::AthenticatedUserTestCase < ATH::Spec::APITestCase
  DEFAULT_USER_ID = 1

  def request(method : String, path : String, body : String | Bytes | IO | Nil = nil, headers : HTTP::Headers = HTTP::Headers.new) : HTTP::Server::Response
    unless headers.has_key? "authorization"
      token = JWT.encode({
        "user_id" => DEFAULT_USER_ID,
        "exp"     => (Time.utc + 1.week).to_unix,
        "iat"     => Time.utc.to_unix,
      },
        ENV["SECRET"],
        :hs512
      )

      headers["authorization"] = "Bearer #{token}"
    end

    super
  end
end
