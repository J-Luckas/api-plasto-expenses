# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/cors'
require './app/guards/jwt_guard'

class BaseRoute < Sinatra::Base
  register Sinatra::Cors
  
  configure do
    set :show_exceptions, false

    set :allow_origin, "http://localhost:3000"
    set :allow_methods, "GET,HEAD,POST"
    set :allow_headers, "content-type,if-modified-since"
    set :expose_headers, "location,link"
  end

  options "*" do
    response.headers["Allow"] = "GET, HEAD, POST, OPTIONS"
    response.headers["Access-Control-Allow-Origin"] = "http://localhost:3000"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type"
    response.headers["Access-Control-Allow-Methods"] = "GET, HEAD, POST, OPTIONS"
    200
  end

  before do
    pass if request.request_method == "OPTIONS"
    
    response.headers['Access-Control-Allow-Origin'] = 'http://localhost:3000'
    AuthGuard::JwtGuard.new(request: request).call
  end

  def self.inherited(subclass)
    super
    subclass.before do
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