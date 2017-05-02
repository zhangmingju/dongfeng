module Oauth
 class ApplicationsController < Doorkeeper::ApplicationsController
   before_action :authenticate_user!
   def create
     @application = Doorkeeper::Application.new(application_params)
     @application.owner = current_user if Doorkeeper.configuration.confirm_application_owner?
     if @application.save
       flash[:notice] = I18n.t(:notice, scope: [:doorkeeper, :flash, :applications, :create])
       redirect_to oauth_application_url(@application)
     else
       render :new
     end
   end
 end
end