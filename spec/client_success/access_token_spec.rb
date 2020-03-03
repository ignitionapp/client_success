require "spec_helper"

module ClientSuccess
  RSpec.describe(AccessToken) do
    subject(:service) { described_class }

    describe "#create" do
      context "with valid credentials" do
        around(:each) do |example|
          VCR.use_cassette("client_success/access_token/valid_credentials") do
            example.run
          end
        end

        it "creates an access token" do
          access_token = service.create(
            username: "CLIENT_SUCCESS_USERNAME",
            password: "CLIENT_SUCCESS_PASSWORD")

          expect(access_token.access_token).to eq("979e3ce5-5f57-486a-af03-d328f50bd356")
          expect(access_token.token_type).to eq("Bearer")
          expect(access_token.expires_in).to eq(43200)
        end
      end

      context "with invalid credentials" do
        around(:each) do |example|
          VCR.use_cassette("client_success/access_token/invalid_credentials") do
            example.run
          end
        end

        it "raises an exception" do
          expect do
            service.create(
              username: "invalid@example.com",
              password: "hunter2")
          end.to raise_error(AccessToken::InvalidCredentials)
        end
      end
    end
  end
end
