# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'dotenv'
Dotenv.load

require './app/adapters/controllers/user_controller'

set :database, { adapter: 'sqlite3', database: ENV['DB_PATH'] }
set :port, 3001

post '/users' do 
  { data: UserController.create(JSON.parse(request.body.read, symbolize_names: true)) }.to_json
end
