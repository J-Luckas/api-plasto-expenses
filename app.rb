# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'dotenv'
Dotenv.load

require './app/adapters/controllers/user_controller'
require './app/adapters/controllers/auth_controller'
require './app/adapters/controllers/goal_definition_controller'
require './app/adapters/controllers/transaction_controller'
require './app/adapters/exceptions/api_exception'
require './app/guards/jwt_guard.rb'

set :database, { adapter: 'sqlite3', database: ENV['DB_PATH'] }
set :port, 3001
set :show_exceptions, false

before do
  AuthGuard::JwtGuard.new(request: request).call
end

# AUTH

post '/auth/sign-in' do
  { access_token: AuthController.sign_in(JSON.parse(request.body.read, symbolize_names: true)) }.to_json
end


post '/auth/sign-up' do 
  { access_token: AuthController.sign_up(JSON.parse(request.body.read, symbolize_names: true)) }.to_json
end

# USERS
get '/users/:user_id' do 
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

