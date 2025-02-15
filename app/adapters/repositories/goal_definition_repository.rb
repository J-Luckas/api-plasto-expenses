# frozen_string_literal: true

require './app/adapters/repositories/transaction_repository'

class GoalDefinitionRepository < ActiveRecord::Base 
  belongs_to :user, class_name: 'UserRepository'
  has_many :transactions, class_name: 'TransactionRepository', foreign_key: 'goal_definition_id'
  self.table_name = 'goals_definition'
end