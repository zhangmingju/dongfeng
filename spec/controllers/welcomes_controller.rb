require 'rails_helper'

RSpec.describe WelcomesController, type: :controller do
  let(:user) { create(:user) }
  describe ":index" do 
    it "render the index template" do 
      get :index
      expect(response).to be_success
      expect(response).to render_template("index")
    end

    it "user center" do 
      sign_in user
      get :index
      expect(response.body).to match(/个人中心/)
    end
  end
end
