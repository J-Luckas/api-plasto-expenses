# frozen_string_literal: true

require './app/model/goal_definition'
require './app/adapters/repositories/goal_definition_repository'

module GoalsDefinition
  class FindOne
    def initialize(params:, goal_definition: GoalDefinition, goal_definition_repository: GoalDefinitionRepository)
      @params = params
      @goal_definition = goal_definition
      @goal_definition_repository = goal_definition_repository
    end

    def call
      found_goals = @goal_definition_repository.includes(:user, :transactions).where("id = ?", @params[:id]).first
      
      
      goal_hash = found_goals.attributes
      goal_hash["user"] = found_goals.user
      goal_hash["transactions"] = found_goals.transactions
      goal_hash
    end
  end
end