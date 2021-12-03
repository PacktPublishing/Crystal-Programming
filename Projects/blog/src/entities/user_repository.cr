class Blog::Entities::User::Repository
  def initialize(@connection : DB::Database); end

  def find(id : Int64) : Blog::Entities::User
    @connection.query_one(%(SELECT * FROM "users" WHERE "id" = $1), id, as: Blog::Entities::User)
  end

  def find_by_username?(username : String) : Blog::Entities::User?
    @connection.query_one?(%(SELECT * FROM "users" WHERE "email" = $1), username, as: Blog::Entities::User)
  end
end
