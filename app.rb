# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'dotenv'
Dotenv.load

require './app/adapters/exceptions/api_exception'
require './app/guards/jwt_guard.rb'

require './app/routes/base_route'
require './app/routes/user_route'
require './app/routes/auth_route'
require './app/routes/goals_definition_route'
require './app/routes/transaction_route'


set :database, { adapter: 'sqlite3', database: ENV['DB_PATH'] }
set :port, 3001


use BaseRoute

use UserRoute
use AuthRoute
use GoalDefinitionRoute
use TransactionRoute


