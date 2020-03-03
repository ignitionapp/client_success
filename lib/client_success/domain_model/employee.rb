require_relative "security_role"

module ClientSuccess
  module DomainModel
    class Employee < Hash
      include Hashie::Extensions::MergeInitializer
      include Hashie::Extensions::IndifferentAccess
      include Hashie::Extensions::MethodAccess
      include Hashie::Extensions::Coercion

      coerce_key :security_roles, Array[SecurityRole]
    end
  end
end
