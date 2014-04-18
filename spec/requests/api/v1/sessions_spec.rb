describe "Sessions API" do
  describe "POST /sessions" do
    it "on success, returns the user's authentication token" do
      user = FactoryGirl.create(:user)

      user_params = {
        "user" => {
          "email" => user.email,
          "password" => user.password
        }
      }.to_json

      post "/sessions", user_params

      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json['authentication_token']).to eq(user.authentication_token)
    end
  end
end
