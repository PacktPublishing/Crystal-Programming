class Blog::Entities::Article::Repository
  def initialize(@database : DB::Database); end

  def find?(id : Int64) : Blog::Entities::Article?
    @database.query_one?(%(SELECT * FROM "articles" WHERE "id" = $1 AND "deleted_at" IS NULL;), id, as: Blog::Entities::Article)
  end

  def find_all : Array(Blog::Entities::Article)
    @database.query_all %(SELECT * FROM "articles" WHERE "deleted_at" IS NULL;), as: Blog::Entities::Article
  end
end
