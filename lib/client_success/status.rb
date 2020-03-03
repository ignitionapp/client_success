require_relative "connection"
require_relative "domain_model/status"

module ClientSuccess
  module Status
    ACTIVE     = 1
    INACTIVE   = 2
    TRIAL      = 3
    TERMINATED = 4

    extend self

    def list_all(connection:)
      response = connection.get(
        "/v1/client-statuses")

      response.body.map do |payload|
        DomainModel::Status.new(
          payload.deep_transform_keys(&:underscore))
      end
    end
  end
end
