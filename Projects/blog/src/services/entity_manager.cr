@[ADI::Register]
class Blog::Services::EntityManager
  @@database : DB::Database = DB.open ENV["DATABASE_URL"]

  def repository(entity_class : Blog::Entities::Article.class) : Blog::Entities::Article::Repository
    @@article_repository ||= Blog::Entities::Article::Repository.new @@database
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

  private def save(entity : Blog::Entities::Article) : Int64
    @@database.scalar(
      %(INSERT INTO "articles" ("title", "body", "created_at", "updated_at", "deleted_at") VALUES ($1, $2, $3, $4, $5) RETURNING "id";),
      entity.title,
      entity.body,
      entity.created_at,
      entity.updated_at,
      entity.deleted_at,
    ).as Int64
  end

  private def update(entity : Blog::Entities::Article) : Nil
    @@database.exec(
      %(UPDATE "articles" SET "title" = $1, "body" = $2, "updated_at" = $3, "deleted_at" = $4 WHERE "id" = $5;),
      entity.title,
      entity.body,
      entity.updated_at,
      entity.deleted_at,
      entity.id
    )
  end
end
