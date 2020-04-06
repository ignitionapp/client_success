require_relative "domain_model/subscription"
require_relative "schema/subscription/create"
require_relative "schema/subscription/update"

module ClientSuccess
  module Subscription
    extend self

    class Error < StandardError; end
    class InvalidAttributes < Error; end

    def create(attributes:, connection:)
      body = Schema::Subscription::Create[attributes]
        .deep_transform_keys { |k| k.to_s.camelize(:lower) }
        .to_json

      response = connection.post(
        "/v1/subscriptions", body)

      if response.body.blank?
        raise InvalidAttributes, "subscription has invalid attributes"
      else
        payload = response.body
        DomainModel::Subscription.new(
          payload.deep_transform_keys(&:underscore))
      end
    end

    def update(attributes:, connection:)
      body = Schema::Subscription::Update[attributes]
                 .deep_transform_keys { |k| k.to_s.camelize(:lower) }
                 .to_json

      response = connection.put(
        "/v1/subscriptions/#{attributes[:id]}", body)

      response.body
    end

    def last(client_id:, connection:)
      response = connection.get(
        "/v1/subscriptions?clientId=#{client_id}")

      payload = response.body.last.to_h

      DomainModel::Subscription.new(
        payload.deep_transform_keys(&:underscore))
    end
  end
end
