class ProductsController < ApplicationController
  layout 'application'
  def index
    @title = "项目投票"
    @products = Product.all.page(params[:page])
  end

  def vote
    flag = true
    begin
      ActiveRecord::Base.transaction do 
        ids = params[:ids]
        products = Product.where("id in (:ids)",:ids=>ids)
        products.each do |p|
          p.update(count: p.count + 1 )
          VoteShip.create(user_id:current_user.id,product_id:p.id)
        end
      end
    rescue Exception => e
      flag = false
      LoggerApp.info(" e.message: #{e.message}")
    end
    render json: {info: flag}
  end
end
