# frozen_string_literal: true

require 'sinatra/base'
require './app/guards/jwt_guard'

class BaseRoute < Sinatra::Base

  configure do
    set :show_exceptions, false
  end

  before do
    AuthGuard::JwtGuard.new(request: request).call
  end

  def self.inherited(subclass)
    super
    subclass.before do
      puts request.path_info
      puts "settt"
      request.path_info = request.path_info.sub(settings.base_path, '')
    end
  end


  error ApiError do
    error = env['sinatra.error']
    content_type :json
    status error.status
    { error: error.message }.to_json
  end
end