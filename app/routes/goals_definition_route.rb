# frozen_string_literal: true

require './app/routes/base_route'
require './app/adapters/controllers/goal_definition_controller'

class GoalDefinitionRoute < BaseRoute

  set :base_path, '/goals-definition'

  post '' do 
    { data: GoalDefinitionController.create(JSON.parse(request.body.read, symbolize_names: true)) }.to_json
  end

  get '/:id' do 
    { data: GoalDefinitionController.find_one(params) }.to_json
  end

end