require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    it 'should return all users' do 
    user = User.create(name: "anil", email:"anil@gmail.com", password:"123456", password_confirmation:"123456")
    user1 = User.create(name: "test", email:"test@gmail.com", password:"123456")
    get '/users'
    
    expect(response).to have_http_status(:success)
  end
  end

  describe 'GET /show' do 
    it 'should show user with id ' do 
      user = User.create(name:"test", email:"test@gmail.com", password:"123456")

      get "/users/#{user.id}" 
       
      expect(JSON.parse(response.body)['id']).to eq(user.id)
      expect(JSON.parse(response.body)['name']).to eq(user.name)
    end
  end 

  describe 'POST /create' do 
    it 'should create user' do 
      post '/users', params:{user:{name:"111", email:"111@gmail.com", password:"123456"}}

    

      expect(JSON.parse(response.body)['name']).to eq('111')
    end 
  end 

  describe 'PUT /update' do 
    it 'should update a user' do 
      user = User.create(name:"test", email: "test@gmail.com", password:"123456")
      put "/users/#{user.id}", params: {user:{name:"anil"}},
                              headers:{ Authorization: JsonWebToken.encode(user_id: user.id)}
      
      expect(JSON.parse(response.body)['name']).to eq("anil")
    end 

    it 'should forbid update user from another user' do 
      user = User.create(name:"test", email:"test@gmail.com", password:"123456")
      user1 = User.create(name:"test2", email:"test2@gmail.com", password:"123456")
      
      put "/users/#{user.id}", params:{user:{name:"anil"}},
                               headers: {Authorization: JsonWebToken.encode(user_id: user1.id)}

      expect(response).to have_http_status(403)
    end
  end 

  describe 'DELETE /destroy' do 
    it 'should be delete user' do 
      user = User.create(name:"anil", email:"anil@gmail.com", password:"123456")
      user2 = User.create(name:"test", email:"rest@gmail.com", password:"1233456")
      delete "/users/#{user.id}", headers:{Authorization:JsonWebToken.encode(user_id: user.id)}
      expect(response).to have_http_status(204)
    end 

    it 'forbid to delete for another user' do 
       user2 = User.create(name:"test", email:"rest@gmail.com", password:"1233456")
       user = User.create(name:"anil", email:"anil@gmail.com", password:"123456")

       delete "/users/#{user.id}", headers:{Authorization: JsonWebToken.encode(user_id: user2.id)}
       expect(response).to have_http_status(403)
    end

  end 

end
