require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:category)}
  let(:article) { create(:article)}

  describe ":show" do
    it 'work' do
      get :show, params: { id: article.slug }
      expect(response).to be_success
      expect(response.body).to match(/#{article.name}/)
    end

  end
end
