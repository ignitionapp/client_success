module ClientSuccess
  module DomainModel
    class AccessToken < Hashie::Dash
      include Hashie::Extensions::IndifferentAccess

      property :access_token
      property :token_type
      property :expires_in
    end
  end
end
