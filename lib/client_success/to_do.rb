require_relative "connection"
require_relative "domain_model/to_do"

module ClientSuccess
  module ToDo
    extend self

    def list_all(client_id:, connection:)
      response = connection.get(
        "/v1/clients/#{client_id}/to-dos")

      response.body.map do |payload|
        DomainModel::ToDo.new(
          payload.deep_transform_keys(&:underscore))
      end
    end

    def create(client_id:, attributes:,
               connection:)
      raise NotImplementedError
    end
  end
end
