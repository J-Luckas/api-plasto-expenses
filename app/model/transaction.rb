# frozen_string_literal: true

class Transaction
  attr_accessor :description, :value, :type

  def initialize(description:, value:, type:)
    @description = description
    @value = value
    @type = type
  end
end
