# frozen_string_literal: true

require './app/usecases/users/create'
require './app/usecases/users/find_one'

class UserController
  def self.create( body )
    user = Users::Create.new(body: body).call

    user
  end
  
  def self.find_one( params )
    user = Users::FindOne.new(params: params).call
    user
  end

end