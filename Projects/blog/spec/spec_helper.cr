require "spec"
require "../src/blog"

require "athena/spec"

DATABASE = DB.open ENV["DATABASE_URL"]

Spec.before_suite do
  DATABASE.exec "ALTER DATABASE \"postgres\" SET SEARCH_PATH TO \"test\";"

  DATABASE.exec File.read "#{__DIR__}/../db/000_setup.sql"
  DATABASE.exec File.read "#{__DIR__}/../db/001_articles.sql"
end

Spec.after_suite do
  DATABASE.exec "ALTER DATABASE \"postgres\" SET SEARCH_PATH TO \"public\";"
  DATABASE.close
end

Spec.before_each do
  DATABASE.exec "TRUNCATE TABLE \"articles\" RESTART IDENTITY;"
end

ASPEC.run_all
