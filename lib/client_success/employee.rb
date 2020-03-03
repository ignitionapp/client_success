require_relative "connection"
require_relative "domain_model/employee"

module ClientSuccess
  module Employee
    extend self

    def list_all(connection:)
      response = connection.get(
        "/v1/employees")

      response.body.map do |payload|
        DomainModel::Employee.new(
          payload.deep_transform_keys(&:underscore))
      end
    end
  end
end
