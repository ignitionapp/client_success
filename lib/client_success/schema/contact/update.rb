require_relative "../../types"

module ClientSuccess
  module Schema
    module Contact
      # TODO: upgrade dry types to use latest schema functions
      Update = Types::Hash.schema(
        email:             Types::Strict::String,
        phone:             Types::Strict::String.optional,
        mobile:            Types::Strict::String.optional,
        title:             Types::Strict::String.optional,
        linkedin_url:      Types::Strict::String.optional,
        first_name:        Types::Strict::String.optional,
        last_name:         Types::Strict::String.optional,
        executive_sponsor: Types::Strict::Bool,
        advocate:          Types::Strict::Bool,
        champion:          Types::Strict::Bool,
        starred:           Types::Strict::Bool,
        street:            Types::Strict::String.optional,
        city:              Types::Strict::String.optional,
        contact_state:     Types::Strict::String.optional,
        zip:               Types::Coercible::String.optional,
        country:           Types::Strict::String.optional,
        timezone:          Types::Strict::String.optional)
    end
  end
end
