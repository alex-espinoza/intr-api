class API::V1::UsersController < API::V1::ApiController
  def index
    render :json => User.all
  end

  def show
    render :json => User.find(params[:id])
  end
end
