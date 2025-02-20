# frozen_string_literal: true

require './app/model/user'
require './app/adapters/repositories/user_repository'

module Users
  class FindOne
    def initialize(user_id:, user: User, user_repository: UserRepository)
      @user_id = user_id
      @user = user
      @user_repository = user_repository
    end

    def call
      found_user = @user_repository.select('id', 'name', 'email').includes(:goal_definitions).where("id = ?", @user_id).first

      if found_user
        user_hash = found_user.attributes
        user_hash["goal_definitions"] = found_user.goal_definitions

        user_hash
      end
  
    end
  end
end