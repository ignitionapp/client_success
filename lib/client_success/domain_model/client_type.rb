require_relative "success_cycle"

module ClientSuccess
  module DomainModel
    class ClientType < Hash
      include Hashie::Extensions::MergeInitializer
      include Hashie::Extensions::IndifferentAccess
      include Hashie::Extensions::MethodAccess
      include Hashie::Extensions::Coercion

      coerce_key :success_cycles, Array[SuccessCycle]
    end
  end
end
