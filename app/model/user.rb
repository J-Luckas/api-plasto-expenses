# frozen_string_literal: true

class User
  attr_accessor :name, :spend_by_day

  def initialize(name:, spend_by_day:)
    @name = name
    @spend_by_day = spend_by_day
  end
end
