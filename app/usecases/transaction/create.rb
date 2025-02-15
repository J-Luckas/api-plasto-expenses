# frozen_string_literal: true

require './app/model/transaction'
require './app/adapters/repositories/transaction_repository'

module Transactions
  class Create
    def initialize(body:, transaction: Transaction, transaction_repository: TransactionRepository)
      @body = body
      @transaction = transaction
      @transaction_repository = transaction_repository
    end

    def call
      transaction = @transaction.new(
        description: @body[:description], 
        value: @body[:value], 
        transaction_type: @body[:transaction_type], 
        goal_definition_id: @body[:goal_definition_id], 
      ).to_hash

      p transaction
      p "pipipip"


      added_goal = @transaction_repository.create(transaction)
      added_goal
    end
  end
end