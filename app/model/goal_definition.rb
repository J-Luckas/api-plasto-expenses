# frozen_string_literal: true

class GoalDefinition
  attr_accessor :name, :description, :default, :spend_by_day, :user_id

  def initialize(name:, description:, default:, user_id:, spend_by_day:)
    @name = name
    @description = description
    @default = default
    @user_id = user_id
    @spend_by_day = spend_by_day
  end

  def to_hash 
    hash = {}
    self.instance_variables.each {|var| hash[var.to_s.delete("@")] = self.instance_variable_get(var) }

    hash
  end
end
