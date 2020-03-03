require_relative "custom_field_value"

module ClientSuccess
  module DomainModel
    class Subscription < Hash
      include Hashie::Extensions::MergeInitializer
      include Hashie::Extensions::IndifferentAccess
      include Hashie::Extensions::MethodAccess
      include Hashie::Extensions::Coercion
    end
  end
end
