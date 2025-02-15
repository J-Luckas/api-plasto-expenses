# frozen_string_literal: true

require './app/usecases/users/create'

class UserController
  def self.create( body )
    user = Users::Create.new(body: body).call

    user
  end
end