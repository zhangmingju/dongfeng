class WelcomesController < ApplicationController
  layout 'application'
  skip_before_action :authenticate_user!
  def index
  end

  def notice
  end
end
