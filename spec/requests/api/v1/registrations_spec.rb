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

      new_user = User.last

      expect(response.status).to eq(200)
      expect(json['success']).to be_true
      expect(json['message']).to eq("New account has been successfully created.")
      expect(json['data']['user']['id']).to eq(new_user.id)
      expect(json['data']['user']['email']).to eq(new_user.email)
      expect(json['data']['user']['authentication_token']).to eq(new_user.authentication_token)
      expect(json['data']['user']['created_at']).to eq(new_user.created_at.as_json)
    end

    it "on failure, does not create a new user" do
      user = FactoryGirl.build(:user)

      user_params = {
                      "user" => {
                        "email" => user.email,
                        "password" => 'thispass',
                        "password_confirmation" => 'doesnotmatch'
                      }
                    }.to_json

      post "/api/v1/registrations", user_params, request_headers

      expect(response.status).to eq(422)
      expect(json['success']).to be_false
      expect(json['message']['password_confirmation'][0]).to eq("doesn't match Password")
    end
  end
end
