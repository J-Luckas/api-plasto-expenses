# frozen_string_literal: true

require './app/routes/base_route'
require './app/adapters/controllers/user_controller'

class UserRoute < BaseRoute

  set :base_path, '/users'

  get '' do
    user = request.env['user']
    { data: UserController.find_one(user['id'])}.to_json
  end

end
