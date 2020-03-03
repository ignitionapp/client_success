require_relative "../../types"

module ClientSuccess
  module Schema
    module Contact
      # TODO: upgrade dry types to use latest schema functions
      Create = Types::Hash.schema(
        email:             Types::Strict::String,
        phone:             Types::Strict::String.optional,
        mobile:            Types::Strict::String.optional,
        title:             Types::Strict::String.optional,
        linkedin_url:      Types::Strict::String,
        first_name:        Types::Strict::String.optional,
        last_name:         Types::Strict::String.optional,
        executive_sponsor: Types::Strict::Bool,
        advocate:          Types::Strict::Bool,
        champion:          Types::Strict::Bool,
        starred:           Types::Strict::Bool,
        street:            Types::Strict::String,
        city:              Types::Strict::String,
        contact_state:     Types::Strict::String,
        zip:               Types::Coercible::String,
        country:           Types::Strict::String,
        timezone:          Types::Strict::String
      )
    end
  end
end
