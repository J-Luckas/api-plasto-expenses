class ApiError < StandardError
  attr_reader :status

  def initialize(message, status = 400)
    super(message)
    @status = status
  end
end