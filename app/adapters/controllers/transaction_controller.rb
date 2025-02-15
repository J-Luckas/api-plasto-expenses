# frozen_string_literal: true
require './app/usecases/transaction/create'
require './app/usecases/transaction/create'

class TransactionController
  def self.create( body )
    transaction = Transactions::Create.new(body: body).call

    transaction
  end
end