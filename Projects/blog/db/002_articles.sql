CREATE TABLE IF NOT EXISTS "articles"
(
    "id"         BIGINT GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    "author_id"  BIGINT                              NOT NULL REFERENCES "users",
    "title"      TEXT                                NOT NULL,
    "body"       TEXT                                NOT NULL,
    "created_at" TIMESTAMP                           NOT NULL,
    "updated_at" TIMESTAMP                           NOT NULL,
    "deleted_at" TIMESTAMP                           NULL
);
