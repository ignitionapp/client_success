require_relative "connection"
require_relative "domain_model/client_type"

module ClientSuccess
  module ClientType
    extend self

    def list_all(connection:)
      response = connection.get(
        "/v1/client-segments")

      response.body.map do |payload|
        DomainModel::ClientType.new(
          payload.deep_transform_keys(&:underscore))
      end
    end
  end
end
