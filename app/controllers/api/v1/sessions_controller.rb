class API::V1::SessionsController < Devise::SessionsController
  include ActionController::MimeResponds
  include ActionController::StrongParameters

  respond_to :json

  def create
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    render :status => 200,
             :json => { :success => true,
                        :message => "You have been successfully logged in.",
                           :data => { :authentication_token => current_user.authentication_token } }
  end

  def failure
    render :status => 401,
             :json => { :success => false,
                        :message => "Invalid email and/or password." }
  end
end