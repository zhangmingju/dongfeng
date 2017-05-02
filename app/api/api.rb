require 'doorkeeper/grape/helpers'
class API < Grape::API
  helpers Doorkeeper::Grape::Helpers
  version 'v1', using: :path
  format :json
  formatter :json, Grape::Formatter::Jbuilder
  prefix :api
  

  before do
    doorkeeper_authorize! :public
  end
  resource :aaa do
    desc "Return a public timeline."
    get :test,jbuilder:"aaa/test"  do
      @article = Article.first
    end
  end
end