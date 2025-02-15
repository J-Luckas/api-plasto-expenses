# frozen_string_literal: true

require './app/model/user'
require './app/adapters/repositories/user_repository'

module Users
  class FindOne
    def initialize(params:, user: User, user_repository: UserRepository)
      @params = params
      @user = user
      @user_repository = user_repository
    end

    def call
      found_user = @user_repository.includes(:goal_definitions).where("id = ?", @params[:user_id]).first

      if found_user
        user_hash = found_user.attributes
        user_hash["goal_definitions"] = found_user.goal_definitions

        user_hash
      end
  
    end
  end
end