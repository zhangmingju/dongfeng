class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  rescue_from CanCan::AccessDenied do |exception|
    LoggerApp.info(" exception: #{exception.message}")
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to main_app.admin_categories_path, :notice => I18n.t("rolify.message") }
    end
  end
end