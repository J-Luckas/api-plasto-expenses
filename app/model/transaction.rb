# frozen_string_literal: true

class Transaction
  attr_accessor :description, :value, :type, :goal_definition_id

  def initialize(description:, value:, transaction_type:, goal_definition_id:)
    @description = self.validateStrings('description', description)
    @value = self.validateValue('value', value)
    @transaction_type = self.validateTypes(transaction_type)
    @goal_definition_id = self.validateStrings('goal_definition_id', goal_definition_id)
  end

  def to_hash 
    hash = {}
    self.instance_variables.each {|var| hash[var.to_s.delete("@")] = self.instance_variable_get(var) }

    hash
  end

  def validateStrings( description, value )
    if value.nil?
      raise ApiError.new( "#{description} não pode ser nulo.", 422 )
    end

    value
  end

  def validateValue( description, value )
    self.validateStrings( description, value )
    if !value.instance_of? Float 
      raise ApiError.new( "#{description} deve ser um número válido.", 422 )
    end

    value
  end

  def validateTypes( value )
    self.validateStrings( 'transaction_type', value )

    valid_transaction_types = %w[IN OUT]
    unless valid_transaction_types.include?(value)
      raise ApiError.new( "Valor de transaction_type inválido. Utilize 'IN' ou 'OUT'.", 422 )
    end

    value
  end
end
