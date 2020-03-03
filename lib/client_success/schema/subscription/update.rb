require_relative "../../types"

module ClientSuccess
  module Schema
    module Subscription
      Update = Types::Hash.schema(
        product_id:   Types::Coercible::Int,
        is_recurring: Types::Strict::Bool,
        amount:       Types::Coercible::Int,
        quantity:     Types::Coercible::Int,
        start_date:   Types::Strict::String,
        end_date:     Types::Strict::String,
        is_potential: Types::Strict::Bool,
        auto_renew:   Types::Strict::Bool,
        note:         Types::Strict::Hash,
        client_id:    Types::Coercible::Int,
        id:           Types::Coercible::Int
      )
    end
  end
end
