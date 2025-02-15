# frozen_string_literal: true
require './app/usecases/goals_definition/create'
require './app/usecases/goals_definition/find_one'

class GoalDefinitionController
  def self.create( body )
    goal_definition = GoalsDefinition::Create.new(body: body).call

    goal_definition
  end
  
  def self.find_one( params )
    goal_definition = GoalsDefinition::FindOne.new(params: params).call
    goal_definition
  end
end