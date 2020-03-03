module ClientSuccess
  module DomainModel
    class Product < Hash
      include Hashie::Extensions::MergeInitializer
      include Hashie::Extensions::IndifferentAccess
      include Hashie::Extensions::MethodAccess
      include Hashie::Extensions::Coercion
    end
  end
end
