require 'rails_helper'

RSpec.describe "Tokens", type: :request do
  describe "post /create" do
    it "should login" do 
      post '/tokens', params:{email:"test@gmail.com", password:"123456"}
      

      expect(JSON.parse(response.body)).not_to be_empty
    end
  end
end
