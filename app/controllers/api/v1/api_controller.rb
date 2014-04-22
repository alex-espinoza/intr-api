class API::V1::ApiController < ApplicationController
  before_filter :authenticate_user

  respond_to :json

  private

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
