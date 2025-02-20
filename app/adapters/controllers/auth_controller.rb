# frozen_string_literal: true

require './app/usecases/users/create'
require './app/usecases/users/find_one'
require './app/usecases/users/find_by_email'
require './app/services/bcrypt_service'
require 'bcrypt'
require 'jwt'

class AuthController
  def self.sign_up( body )
    found_user = Users::FindByEmail.new(params: body).call

    raise ApiError.new( "Usuário já existe!", 409 ) unless !found_user
    
    hashed_password = BcryptService.encode_password(body[:password]) 
    body[:password] = hashed_password
    user = Users::Create.new(body: body).call

    payload = { user: user.attributes.except("password"), exp: Time.now.to_i + 3600 }
    token = JWT.encode(payload, ENV['VALID_ACCESS_SECRET'], 'HS256')
    { token: token }
  end
  
  def self.sign_in( body )
    found_user = Users::FindByEmail.new(params: body).call

    raise ApiError.new( "Credenciais inválidas!", 401 ) unless found_user && BCrypt::Password.new(found_user.password) == body[:password]

    payload = { user: found_user.attributes.except("password"), exp: Time.now.to_i + 3600 }
    token = JWT.encode(payload, ENV['VALID_ACCESS_SECRET'], 'HS256')
    token
  end
end