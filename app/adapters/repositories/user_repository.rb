# frozen_string_literal: true

class UserRepository < ActiveRecord::Base 
  has_many :goal_definitions, class_name: 'GoalDefinitionRepository', foreign_key: 'user_id'
  self.table_name = 'users'
end