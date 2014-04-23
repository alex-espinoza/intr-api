class API::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(user_params)
    if resource.save
      return render :status => 200,
                      :json => { :success => true,
                                 :message => "New account has been successfully created.",
                                    :data => { :user => { :id => resource.id,
                                                          :email => resource.email,
                                                          :authentication_token => resource.authentication_token,
                                                          :created_at => resource.created_at } } }
    else
      return render :status => 422,
                      :json => { :success => false,
                                 :message => resource.errors }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
