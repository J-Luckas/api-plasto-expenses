# frozen_string_literal: true

class User
  attr_accessor :name, :email, :password

  def initialize(name:, email:, password:)
    @name = name
    @email = email
    @password = password
  end

  def to_hash 
    hash = {}
    self.instance_variables.each {|var| hash[var.to_s.delete("@")] = self.instance_variable_get(var) }

    hash
  end
end
