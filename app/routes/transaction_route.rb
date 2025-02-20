# frozen_string_literal: true

require './app/routes/base_route'
require './app/adapters/controllers/transaction_controller'

class TransactionRoute < BaseRoute
  set :base_path, '/transactions'

  post '' do 
    { data: TransactionController.create(JSON.parse(request.body.read, symbolize_names: true)) }.to_json
  end

end
