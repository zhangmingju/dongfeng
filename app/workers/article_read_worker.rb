class ArticleReadWorker
  include Sidekiq::Worker

  def perform(article_slug)
    begin
      article = Article.friendly.find(article_slug)
      article.update(read_count: article.read_count + 1)
    rescue Exception => e
      LoggerApp.info("  #{self.class.name}.#{__method__}  e.message: #{e.message}")
    end
  end
  
end
