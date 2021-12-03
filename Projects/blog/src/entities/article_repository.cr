class Blog::Entities::Article::Repository
  def initialize(@connection : DB::Database); end

  def find(id : Int64) : Blog::Entities::Article
    @connection.query_one(%(SELECT * FROM "articles" WHERE "id" = $1 AND "deleted_at" IS NULL;), id, as: Blog::Entities::Article)
  end

  def find?(id : Int64) : Blog::Entities::Article?
    @connection.query_one?(%(SELECT * FROM "articles" WHERE "id" = $1AND "deleted_at" IS NULL;), id, as: Blog::Entities::Article)
  end

  def find_by_author(user_id : Int64) : Array(Blog::Entities::Article)
    @connection.query_all %(SELECT * FROM "articles" WHERE "author_id" = $1 AND "deleted_at" IS NULL;), user_id, as: Blog::Entities::Article
  end
end
