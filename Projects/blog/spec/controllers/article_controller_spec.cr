require "../spec_helper"

struct ArticleControllerTest < Blog::Spec::AthenticatedUserTestCase
  def test_get_article : Nil
    DATABASE.exec <<-SQL
      INSERT INTO "articles" (id, author_id, title, body, created_at, updated_at) OVERRIDING SYSTEM VALUE
      VALUES (10, #{DEFAULT_USER_ID}, 'TITLE', 'BODY', timezone('utc', now()), timezone('utc', now()));
    SQL

    response = self.get "/article/10"

    response.status.should eq HTTP::Status::OK

    article = JSON.parse response.body
    article["title"].as_s.should eq "TITLE"
    article["body"].as_s.should eq "BODY"
  end

  def test_get_article_html : Nil
    DATABASE.exec <<-SQL
      INSERT INTO "articles" (id, author_id, title, body, created_at, updated_at) OVERRIDING SYSTEM VALUE
      VALUES (10, #{DEFAULT_USER_ID}, 'TITLE', 'BODY', timezone('utc', now()), timezone('utc', now()));
    SQL

    response = self.get "/article/10", headers: HTTP::Headers{"accept" => "text/html"}

    response.status.should eq HTTP::Status::OK
    response.body.should contain "<p>BODY</p>"
  end

  def test_post_article : Nil
    response = self.post "/article", body: %({"title":"TITLE","body":"BODY"})

    article = JSON.parse response.body
    article["title"].as_s.should eq "TITLE"
    article["body"].as_s.should eq "BODY"
    article["created_at"].as_s?.should_not be_nil
    article["id"].raw.should be_a Int64
  end
end
