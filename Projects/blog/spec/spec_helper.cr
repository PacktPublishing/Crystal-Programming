require "spec"
require "../src/blog"

require "athena/spec"

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

DATABASE = DB.open ENV["DATABASE_URL"]

Spec.before_suite do
  DATABASE.exec "ALTER DATABASE \"postgres\" SET SEARCH_PATH TO \"test\";"

  DATABASE.exec File.read "#{__DIR__}/../db/000_setup.sql"
  DATABASE.exec File.read "#{__DIR__}/../db/001_users.sql"
  DATABASE.exec File.read "#{__DIR__}/../db/002_articles.sql"
end

Spec.after_suite do
  DATABASE.exec "ALTER DATABASE \"postgres\" SET SEARCH_PATH TO \"public\";"
  DATABASE.close
end

Spec.around_each do |example|
  DATABASE.exec "TRUNCATE TABLE \"articles\" RESTART IDENTITY;"
  DATABASE.exec "TRUNCATE TABLE \"users\" RESTART IDENTITY CASCADE;"
  DATABASE.exec <<-SQL
    INSERT INTO "users" (id, first_name, last_name, email, password, created_at, updated_at) OVERRIDING SYSTEM VALUE
    VALUES (#{Blog::Spec::AthenticatedUserTestCase::DEFAULT_USER_ID}, 'FIRST', 'LAST', 'EMAIL', 'PASSWORD',
            timezone('utc', now()), timezone('utc', now()));
  SQL
  example.run
end

ASPEC.run_all
