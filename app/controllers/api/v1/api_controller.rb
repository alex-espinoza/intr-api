class API::V1::ApiController < ApplicationController
  before_filter :authenticate_user

  respond_to :json

  private

  def authenticate_user
    unless authenticate_user_by_header
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      return render :status => 401,
                      :json => { :success => false,
                                 :message => "Invalid API token." }
    end
  end

  def authenticate_user_by_header
    return true if current_user

    auth_header = request.headers['Authorization'].to_s
    token = auth_header.sub(/^Token: /, '')
    if token
      User.find_by(authentication_token: token) ? true : false
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
