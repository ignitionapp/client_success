require_relative "domain_model/product"

module ClientSuccess
  module Product
    extend self

    def list_all(connection:)
      response = connection.get("/v1/products")

      response.body.map do |payload|
        DomainModel::Product.new(
          payload.deep_transform_keys(&:underscore))
      end
    end
  end
end
