require 'spec_helper'

describe API::V1::RegistrationsController do
  describe "POST /registrations" do
    it "on success, creates a new user" do
      user = FactoryGirl.build(:user)

      user_params = {
                      "user" => {
                        "email" => user.email,
                        "password" => user.password,
                        "password_confirmation" => user.password
                      }
                    }.to_json

      post "/api/v1/registrations", user_params, request_headers

      expect(request.status).to eq(200)
      expect(json['message']).to eq("New account has been successfully created.")
    end
  end
end
