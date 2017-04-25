require "rails_helper"

RSpec.describe Article, :type => :model do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:article) { create(:article, user: user, category: category) }

  describe '#name' do 
    content 'normal' do  
      let(:article) { build(:article,title:'ttt') }
      it {expect(article.valid?).to eq true}
    end
  end


end