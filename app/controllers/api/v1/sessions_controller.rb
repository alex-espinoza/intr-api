class API::V1::SessionsController < API::V1::ApiController
  skip_before_filter :authenticate_user, only: [:create, :failure]

  before_filter :ensure_params_exist, only: [:create]

  def create
    email, password = params[:user][:email], params[:user][:password]
    user = User.find_by(email: email)

    if user && user.valid_password?(password)
      session[:user_id] = user.id
      return render :status => 200,
                      :json => { :success => true,
                                 :message => "You have been successfully logged in.",
                                    :data => { :user_token => user.authentication_token,
                                               :user_email => user.email } }
    else
      return failure
    end
  end

  def destroy
    # Authentication token is set to nil, so when update_attribute saves the record,
    # a new authentication token is generated for the current_user with the User model
    # before_save callback
    current_user.update_attribute(:authentication_token, nil)
    session[:user_id] = nil
    return render :status => 200,
                    :json => { :success => true,
                               :message => "You have been successfully logged out." }
  end

  def failure
    return render :status => 401,
                    :json => { :success => false,
                               :message => "Invalid email and/or password." }
  end

  private

  def ensure_params_exist
    if params[:user][:email].blank? || params[:user][:password].blank?
      return render :status => 422,
                      :json => { :success => false,
                                 :message => 'Missing email or password parameter.' }
    end
  end
end