# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'dotenv'
Dotenv.load

require './app/adapters/controllers/user_controller'
require './app/adapters/controllers/goal_definition_controller'
require './app/adapters/controllers/transaction_controller'
require './app/adapters/exceptions/api_exception'

set :database, { adapter: 'sqlite3', database: ENV['DB_PATH'] }
set :port, 3001
set :show_exceptions, false

# USER

post '/users' do 
  { data: UserController.create(JSON.parse(request.body.read, symbolize_names: true)) }.to_json
end

get '/users/:user_id/goals-definition' do 
  { data: UserController.find_one(params)}.to_json
end

# GOALS
post '/goals-definition' do 
  { data: GoalDefinitionController.create(JSON.parse(request.body.read, symbolize_names: true)) }.to_json
end

get '/goals-definition/:id' do 
  { data: GoalDefinitionController.find_one(params) }.to_json
end

# TRANSACTIONS

post '/transactions' do 
  { data: TransactionController.create(JSON.parse(request.body.read, symbolize_names: true)) }.to_json
end


error ApiError do
  error = env['sinatra.error']
  content_type :json
  status error.status
  { error: error.message }.to_json
end

