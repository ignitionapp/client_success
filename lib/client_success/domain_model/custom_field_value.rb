module ClientSuccess
  module DomainModel
    class CustomFieldValue < Hash
      include Hashie::Extensions::MergeInitializer
      include Hashie::Extensions::IndifferentAccess
      include Hashie::Extensions::MethodAccess
    end
  end
end
