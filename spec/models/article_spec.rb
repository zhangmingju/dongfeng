require 'rails_helper'

RSpec.describe Article, type: :model do
  before(:all) do 
    @new_article = Article.create!(name:"2",content:"22",publish_state:1)
  end
  before(:each) do 
    @article = Article.create!(name:"1",content:"11",publish_state:1)
  end

  it "article hits" do
    3.times do
      @article.incr_hits
    end
    expect(@article.hits).to eq 3 
  end

  it "article incr_hits" do 
    @article.incr_hits
    expect(@article.hits).to eq 1
  end

  it "order by hits" do 
    3.times do 
      @article.incr_hits
    end
    sort_ids = @new_article.hits > @article.hits ? [@new_article.id,@article.id] : [@article.id,@new_article.id]
    
    expect(Article.hits_sort.pluck(:id)).to eq(sort_ids)
  end

  it "publish_state" do
    article_ids = Article.publish.pluck(:id) 
    ids = [@new_article.id,@article.id]
    expect(article_ids).to eq(ids)
  end
  
  after(:each) do 
    @article.destroy
  end
  after(:all) do
    @new_article.destroy 
  end
end
