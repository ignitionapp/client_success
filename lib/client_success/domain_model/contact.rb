# require_relative "custom_field_value"

module ClientSuccess
  module DomainModel
    class Contact < Hash
      include Hashie::Extensions::MergeInitializer
      include Hashie::Extensions::IndifferentAccess
      include Hashie::Extensions::MethodAccess
      # include Hashie::Extensions::Coercion

      # coerce_key :custom_field_values, Array[CustomFieldValue]
    end
  end
end
