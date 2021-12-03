@[ADI::Register]
class Blog::Services::EntityManager
  @@connection : DB::Database = DB.open ENV["DATABASE_URL"]

  def repository(entity_class : Blog::Entities::User.class) : Blog::Entities::User::Repository
    @@user_repository ||= Blog::Entities::User::Repository.new @@connection
  end

  def repository(entity_class : Blog::Entities::Article.class) : Blog::Entities::Article::Repository
    @@article_repository ||= Blog::Entities::Article::Repository.new @@connection
  end

  def remove(entity : DB::Serializable) : Nil
    entity.on_remove if entity.responds_to? :on_remove
    self.update entity
  end

  def persist(entity : DB::Serializable) : Nil
    entity.before_save if entity.responds_to? :before_save

    id = if entity.id?.nil?
           self.save entity
         else
           return self.update entity
         end

    entity.after_save id
  end

  private def save(entity : Blog::Entities::User) : Int64
    @@connection.scalar(
      %(INSERT INTO "users" ("first_name", "last_name", "email", "password", "created_at", "updated_at", "deleted_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id";),
      entity.first_name,
      entity.last_name,
      entity.email,
      entity.password,
      entity.created_at,
      entity.updated_at,
      entity.deleted_at,
    ).as Int64
  end

  private def save(entity : Blog::Entities::Article) : Int64
    @@connection.scalar(
      %(INSERT INTO "articles" ("author_id", "title", "body", "created_at", "updated_at", "deleted_at") VALUES ($1, $2, $3, $4, $5, $6) RETURNING "id";),
      entity.author_id,
      entity.title,
      entity.body,
      entity.created_at,
      entity.updated_at,
      entity.deleted_at,
    ).as Int64
  end

  private def update(entity : Blog::Entities::Article) : Nil
    @@connection.exec(
      %(UPDATE "articles" SET "title" = $1, "body" = $2, "updated_at" = $3, "deleted_at" = $4 WHERE "id" = $5;),
      entity.title,
      entity.body,
      entity.updated_at,
      entity.deleted_at,
      entity.id
    )
  end

  private def update(entity : Blog::Entities::User) : Nil
    @@connection.exec(
      %(UPDATE "users" SET "first_name" = $1, "last_name" = $2, "email" = $3, "password" = $4, "updated_at" = $5, "deleted_at" = $6 WHERE "id" = $7;),
      entity.first_name,
      entity.last_name,
      entity.email,
      entity.password,
      entity.updated_at,
      entity.deleted_at,
      entity.id
    )
  end
end
