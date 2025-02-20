require 'jwt'

module AuthGuard
  class JwtGuard
    def initialize(request:)
      @request = request
    end

    def call
      if  !(['/auth/sign-in', '/auth/sign-up'] & [@request.path_info]).any?
        access_token = @request.env['HTTP_AUTHORIZATION']&.split

        raise ApiError.new( "Token de acesso não fornecido.", 401 ) unless access_token

        begin
          decoded_token = JWT.decode(access_token[1], ENV['VALID_ACCESS_SECRET'], true, { algorithm: 'HS256' })
          @request.env['user'] = decoded_token.first['user'].except('exp')
        rescue JWT::ExpiredSignature
          raise ApiError.new( "Token de acesso inválido.", 401 )
        rescue JWT::VerificationError
          raise ApiError.new( "Token de acesso inválido.", 401 )
        rescue JWT::DecodeError => e
          puts e
          raise ApiError.new( "Ocorreu um erro inesperado.", 500 )
        end
      end
    end
  end
end