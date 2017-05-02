require 'rails_helper'

RSpec.describe Article, type: :model do

  it "article hits" do |ex|
    article = create(:publish_article)
    expect(article.hits).to eq 0
  end

end
