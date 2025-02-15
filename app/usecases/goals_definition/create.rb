# frozen_string_literal: true

require './app/model/goal_definition'
require './app/adapters/repositories/goal_definition_repository'

module GoalsDefinition
  class Create
    def initialize(body:, goal_definition: GoalDefinition, goal_definition_repository: GoalDefinitionRepository)
      @body = body
      @goal_definition = goal_definition
      @goal_definition_repository = goal_definition_repository
    end

    def call
      goal_definition = @goal_definition.new(
        name: @body[:name], 
        description: @body[:description], 
        default: @body[:default], 
        user_id: @body[:user_id], 
      ).to_hash

      added_goal = @goal_definition_repository.create(goal_definition)
      added_goal
    end
  end
end