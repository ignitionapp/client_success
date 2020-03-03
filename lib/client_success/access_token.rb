require_relative "connection"
require_relative "domain_model/access_token"

module ClientSuccess
  module AccessToken
    extend self

    class Error < StandardError; end
    class InvalidCredentials < Error; end

    def create(username:, password:,
               connection: ClientSuccess::Connection.new)
      response = connection.post("/v1/auth",
        username: username,
        password: password)

      payload = response.body

      DomainModel::AccessToken.new(
        payload.deep_transform_keys(&:underscore))
    rescue Connection::Unauthorised
      raise InvalidCredentials, "invalid username or password"
    end
  end
end
