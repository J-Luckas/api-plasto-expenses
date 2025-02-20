# frozen_string_literal: true

require './app/routes/base_route'
require './app/adapters/controllers/auth_controller'

class AuthRoute < BaseRoute

  set :base_path, '/auth'

  post '/sign-in' do
    { access_token: AuthController.sign_in(JSON.parse(request.body.read, symbolize_names: true)) }.to_json
  end

  post '/sign-up' do 
    { access_token: AuthController.sign_up(JSON.parse(request.body.read, symbolize_names: true)) }.to_json
  end

end