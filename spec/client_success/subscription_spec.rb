require "spec_helper"

module ClientSuccess
  RSpec.describe(Subscription) do
    let(:access_token) { "38dc5069-08fe-4bc0-a7e6-59f6286e2f16" }
    let(:connection) { Connection.authorised(access_token) }

    describe ".create" do
      let(:attributes) do
        {
          product_id: 9224,
          is_recurring: true,
          amount: 100,
          quantity: 1,
          start_date: "2018-12-10",
          end_date: "2018-12-10",
          is_potential: false,
          auto_renew: true,
          client_id: 90334223
        }
      end

      it "creates a subscription" do
        VCR.use_cassette("client_success/subscription/create") do
          subscription = Subscription.create(
            attributes: attributes,
            connection: connection)

          expect(subscription.product_id).to eq(attributes[:product_id])
          expect(subscription.is_recurring).to eq(attributes[:is_recurring])
          expect(subscription.amount).to eq(attributes[:amount])
          expect(subscription.start_date).to eq(attributes[:start_date])
          expect(subscription.end_date).to eq(attributes[:end_date])
          expect(subscription.client_id).to eq(attributes[:client_id])
        end
      end

      # This spec relied on JSON.parse blowing up when parsing "null", but
      # it works with the newer parser.
      xit "raises an error with invalid attributes" do
        attributes[:client_id] = 0
        attributes[:product_id] = 0

        VCR.use_cassette("client_success/subscription/create/failed") do
          expect do
            Subscription.create(
              attributes: attributes,
              connection: connection)
          end.to raise_error(ClientSuccess::Connection::ParsingError)
        end
      end
    end
  end
end
