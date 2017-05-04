module V1
  class ApiArticle < Grape::API
    version 'v1', using: :path

    # before do
    #   doorkeeper_authorize! :public
    # end
    resources 'articles' do

      desc "get single article"
      params do 
        requires :slug,type:String
      end
      get 'show/:slug',jbuilder:'articles/show' do
        begin
          LoggerApp.info(" params[:slug] : #{params[:slug]}")
          @article = Article.find_by(slug:params[:slug])
        rescue Exception => e
          LoggerApp.info(" e.message : #{e.message}")
        end

      end

      desc "get all articles"
      get '',jbuilder: '/articles/index' do 
        @articles = Article.publish.default_order.page(params[:page])
      end
    end
  end
end