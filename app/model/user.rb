# frozen_string_literal: true

class User
  attr_accessor :name, :spend_by_day

  def initialize(name:, spend_by_day:)
    @name = name
    @spend_by_day = spend_by_day
  end

  def to_hash 
    hash = {}
    self.instance_variables.each {|var| hash[var.to_s.delete("@")] = self.instance_variable_get(var) }

    hash
  end
end
