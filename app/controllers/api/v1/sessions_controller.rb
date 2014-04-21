class API::V1::SessionsController < Devise::SessionsController
  include ActionController::MimeResponds
  include ActionController::StrongParameters

  respond_to :json

  def create
  end
end