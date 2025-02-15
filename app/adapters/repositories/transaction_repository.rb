# frozen_string_literal: true

class TransactionRepository < ActiveRecord::Base 
  belongs_to :goal_definition, class_name: 'GoalDefinitionRepository', foreign_key: 'goal_definition_id'
  self.table_name = 'transactions'
end