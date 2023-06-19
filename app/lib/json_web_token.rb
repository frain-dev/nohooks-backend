# frozen_string_literal: true

require 'exception_handler'

class JsonWebToken
  def self.encode(payload,
                  time = ENV['JWT_DEFAULT_EXPIRY_TIME'].to_i.minutes.from_now(Time.now))

    payload[:exp] = time.to_i
    payload[:jti] = create_jti
    payload[:aud] = ENV['JWT_AUD']

    JWT.encode(payload, ENV['JWT_SECRET_KEY'], algorithm = 'HS256', header_fields = { typ: 'JWT' })
  end

  def self.decode(token)
    body = JWT.decode(token, ENV['JWT_SECRET_KEY'], true, { algorithm: 'HS256' })[0]
    HashWithIndifferentAccess.new(body)
  rescue JWT::DecodeError => e
    raise ExceptionHandler::InvalidToken, e.message
  end

  def self.create_jti
    jti_raw = [ENV['JWT_SECRET_KEY'], Time.now.to_i].join(':').to_s
    Digest::MD5.hexdigest(jti_raw)
  end
end
