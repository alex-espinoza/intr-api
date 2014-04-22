class API::V1::SessionsController < Devise::SessionsController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::MimeResponds

  before_filter :authenticate_user

  skip_before_filter :authenticate_user, only: [:create, :failure]

  respond_to :json

  def create
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    render :status => 200,
             :json => { :success => true,
                        :message => "You have been successfully logged in.",
                           :data => { :authentication_token => current_user.authentication_token } }
  end

  def destroy
    # Authentication token is set to nil, so when update_attribute saves the record,
    # a new authentication token is generated for the current_user with the User model
    # before_save callback
    @current_user.update_attribute(:authentication_token, nil)
    render :status => 200,
             :json => { :success => true,
                        :message => "You have been successfully logged out." }
  end

  def failure
    render :status => 401,
             :json => { :success => false,
                        :message => "Invalid email and/or password." }
  end

  private

  # This is SO ugly. I originally intended to have the authentication logic shared
  # via this controller inherting from API::V1::ApiController but I have to use
  # Devise::SessionsController for warden.authenciate! I'll DRY this up later
  # via ActionController::Base.helpers or do something custom and not use warden.

  def authenticate_user
    unless authenticate_user_by_params || authenticate_user_by_header
      return render :status => 401,
                      :json => { :success => false,
                                 :message => "Invalid API token." }
    end

    @current_user = @authenticated_user if @authenticated_user
  end

  def authenticate_user_by_params
    return true if @authenticated_user

    @authenticated_user = User.find_by(authentication_token: params[:authentication_token])
  end

  def authenticate_user_by_header
    return true if @authenticated_user

    authenticate_with_http_token do |token|
      @authenticated_user = User.find_by(authentication_token: token)
    end
  end
end