# frozen_string_literal: true

class Transaction
  attr_accessor :description, :value, :type, :goal_definition_id

  def initialize(description:, value:, transaction_type:, goal_definition_id:)
    @description = description
    @value = value
    @transaction_type = transaction_type
    @goal_definition_id = goal_definition_id
  end

  def to_hash 
    hash = {}
    self.instance_variables.each {|var| hash[var.to_s.delete("@")] = self.instance_variable_get(var) }

    hash
  end
end
