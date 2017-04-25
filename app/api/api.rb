class API < Grape::API
  version 'v1', using: :path
  format :json
  formatter :json, Grape::Formatter::Jbuilder
  prefix :api


  resource :aaa do
    desc "Return a public timeline."
    get :test,jbuilder:"aaa/test"  do
      @article = Article.first
    end
  end
end