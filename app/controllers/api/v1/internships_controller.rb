class API::V1::InternshipsController < API::V1::ApiController
  before_filter :load_user

  def index
    render :json => @user.internships
  end

  def show
    render :json => @user.internships.find(params[:id])
  end

  private

  def load_user
    @user = User.find(params[:user_id])
  end
end
