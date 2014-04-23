require 'spec_helper'

describe API::V1::SessionsController do
  before(:each) { @user = FactoryGirl.create(:user) }

  describe "POST /sessions" do
    it "on success, returns the user's authentication token" do
      user_params = build_user_params(@user.email, @user.password)

      post "/api/v1/sessions", user_params, request_headers

      expect(response.status).to eq(200)
      expect(json['success']).to be_true
      expect(json['message']).to eq("You have been successfully logged in.")
      expect(json['data']['authentication_token']).to eq(@user.authentication_token)
    end

    it "on failure, returns error message" do
      user_params = build_user_params(@user.email, 'wrongpassword')

      post "/api/v1/sessions", user_params, request_headers

      expect(response.status).to eq(401)
      expect(json['success']).to be_false
      expect(json['message']).to eq("Invalid email and/or password.")
    end

    def build_user_params(email, password)
      {
        "user" => {
          "email" => email,
          "password" => password
        }
      }.to_json
    end
  end

  describe "DELETE /sessions" do
    it "destroys and recreates the user's authentication token" do
      old_token = @user.authentication_token

      delete "/api/v1/sessions?authentication_token=#{@user.authentication_token}", {}, request_headers

      expect(response.status).to eq(200)
      expect(json['success']).to be_true
      expect(json['message']).to eq("You have been successfully logged out.")
      expect(@user.reload.authentication_token).to_not eq(old_token)
    end
  end
end
