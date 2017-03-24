class Admin::HomesController < ApplicationController
  layout 'application'
  def index
  end

  def show
    @category = Category.friendly.find(params[:id])
  end
end
