# frozen_string_literal: true

require './app/model/user'
require './app/adapters/repositories/user_repository'

module Users
  class FindByEmail
    def initialize(params:, user_repository: UserRepository)
      @params = params
      @user_repository = user_repository
    end

    def call
      found_user = @user_repository.where("email = ?", @params[:email]).first

      found_user
    end
  end
end