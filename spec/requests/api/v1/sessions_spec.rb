require 'spec_helper'

describe API::V1::SessionsController do
  describe "POST /sessions" do
    it "on success, returns the user's authentication token" do
      user = FactoryGirl.create(:user)

      user_params = {
        "user" => {
          "email" => user.email,
          "password" => user.password
        }
      }.to_json

      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }

      post "/api/v1/sessions", user_params, request_headers

      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json['success']).to be_true
      expect(json['message']).to eq("You have been successfully logged in.")
      expect(json['data']['authentication_token']).to eq(user.authentication_token)
    end

    it "on failure, returns error message" do
      user = FactoryGirl.create(:user)

      user_params = {
        "user" => {
          "email" => user.email,
          "password" => 'nottherightpass'
        }
      }.to_json

      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }

      post "/api/v1/sessions", user_params, request_headers

      expect(response.status).to eq(401)
      json = JSON.parse(response.body)
      expect(json['success']).to be_false
      expect(json['message']).to eq("Invalid email and/or password.")
    end
  end
end
