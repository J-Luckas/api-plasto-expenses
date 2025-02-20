# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'jwt'
require 'dotenv'
Dotenv.load

require './app/adapters/controllers/user_controller'
require './app/adapters/controllers/goal_definition_controller'
require './app/adapters/controllers/transaction_controller'
require './app/adapters/exceptions/api_exception'

set :database, { adapter: 'sqlite3', database: ENV['DB_PATH'] }
set :port, 3001
set :show_exceptions, false

before do
  if request.path_info != '/login'
    access_token = request.env['HTTP_AUTHORIZATION']&.split

    halt 401, { error: 'Token de acesso não fornecido' }.to_json unless access_token

    begin
      puts access_token[1]
      puts 'tokeeennn'
      decoded_token = JWT.decode(access_token[1], ENV['VALID_ACCESS_SECRET'], true, { algorithm: 'HS256' })
    rescue JWT::ExpiredSignature
      halt 401, { error: 'Token de acesso inválido' }.to_json
    rescue JWT::DecodeError => e
      puts e
      halt 500, { error: 'Ocorreu um erro inesperado!' }.to_json
    end
  end
end

# AUTH

post '/login' do
  credentials = JSON.parse(request.body.read, symbolize_names: true)
  
  if credentials[:username] == 'admin' && credentials[:password] == '123456'
    payload = { user: credentials[:username], exp: Time.now.to_i + 3600 }
    token = JWT.encode(payload, ENV['VALID_ACCESS_SECRET'], 'HS256')
    { token: token }.to_json
  else
    halt 401, { error: 'Credenciais inválidas' }.to_json
  end
end

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

