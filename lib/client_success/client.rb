require_relative "connection"
require_relative "domain_model/client"
require_relative "schema/client/create"
require_relative "schema/client/update"

module ClientSuccess
  module Client
    extend self

    class Error < StandardError; end
    class NotFound < Error; end

    def list_all(assigned_csm_id: nil, active_only: true,
             connection:)
      params = {
        "assignedCsmId" => assigned_csm_id,
        "activeOnly" => active_only
      }

      response = connection.get(
        "/v1/clients?#{params.compact.to_query}")

      response.body.map do |payload|
        DomainModel::Client.new(
          payload.deep_transform_keys(&:underscore))
      end
    end

    def get_details(client_id:, connection:)
      response = connection.get(
        "/v1/clients/#{client_id}")

      payload = response.body

      DomainModel::Client.new(
        payload.deep_transform_keys(&:underscore))
    rescue Connection::NotFound
      raise NotFound, "client with id '#{client_id}' not found"
    end

    def get_details_by_external_id(external_id:, connection:)
      params = {
        "externalId" => external_id
      }

      response = connection.get(
        "/v1/clients?#{params.compact.to_query}")

      payload = response.body

      DomainModel::Client.new(
        payload.deep_transform_keys(&:underscore))
    rescue Connection::NotFound
      raise NotFound, "client with external id '#{external_id}' not found"
    end

    def create(attributes:, connection:)
      attributes = connection.strip_emojis(attributes)

      body = Schema::Client::Create[attributes]
        .transform_keys { |k| k.to_s.camelize(:lower) }
        .to_json

      response = connection.post(
        "/v1/clients", body)

      payload = response.body

      # TODO: find a better way to deal with api weirdness here
      payload["customFieldValues"].compact!

      DomainModel::Client.new(
        payload.deep_transform_keys(&:underscore))
    end

    # NOTE: according to the api documentation, this is _not_ a PATCH operation,
    #       i.e. any fields not supplied will be set to null - so make sure you
    #       supply everything :)
    def update(client_id:, attributes:, connection:)
      attributes = connection.strip_emojis(attributes)

      body = attributes
        .deep_transform_keys { |k| k.to_s.camelize(:lower) }
        .to_json

      response = connection.put(
        "/v1/clients/#{client_id}", body)

      payload = response.body

      # TODO: find a better way to deal with api weirdness here
      payload["customFieldValues"].compact!

      DomainModel::Client.new(
        payload.deep_transform_keys(&:underscore))
    end

    def update_custom_field(client_id:, custom_field_name:, value:, connection:)
      body = {
        custom_field_name => value.to_s
      }

      begin
        connection.patch(
          "/v1/customfield/value/client/#{client_id}", body)
      rescue Connection::ParsingError => error
        # NOTE: request submitted to resolve invalid JSON response from client
        #       success for this endpoint
        raise error unless error.message =~ /Update successful/
      end
    end

    def delete(client_id:, connection:)
      # TODO: handle response
      connection.delete(
        "/v1/clients/#{client_id}")
    end
  end
end
