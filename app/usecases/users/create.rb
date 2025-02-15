# frozen_string_literal: true

require './app/model/user'
require './app/adapters/repositories/user_repository'

module Users
  class Create
    def initialize(body:, user: User, user_repository: UserRepository)
      @body = body
      @user = user
      @user_repository = user_repository
    end

    def call
      user = @user.new(name: @body[:name], spend_by_day: @body[:spend_by_day]).to_hash

      added_user = @user_repository.create(user)
      added_user
    end
  end
end