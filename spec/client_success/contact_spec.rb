require "spec_helper"

module ClientSuccess
  RSpec.describe(Contact) do
    subject(:service) { described_class }

    let(:access_token) { "124f4ab2-c951-4dd2-9519-5546eaa20bc6" }
    let(:connection) { Connection.authorised(access_token) }

    describe "#create" do
      around(:each) do |example|
        VCR.use_cassette("client_success/contact/create") do
          example.run
        end
      end

      let(:attributes) do
        {
          email:             Faker::Internet.email,
          phone:             Faker::PhoneNumber.phone_number,
          mobile:            Faker::PhoneNumber.cell_phone,
          title:             Faker::Job.title,
          linkedin_url:      Faker::Internet.url(host: "linkedin.com"),
          first_name:        Faker::Name.first_name,
          last_name:         Faker::Name.last_name,
          street:            Faker::Address.street_address,
          city:              Faker::Address.city,
          contact_state:     Faker::Address.state,
          zip:               Faker::Address.zip_code,
          country:           Faker::Address.country
        }
      end

      it "creates a new contact" do
        contact = service.create(
          client_id: 90289610,
          attributes: attributes,
          connection: connection)

        expect(contact).to eq(
          "id"                  => 10740139,
          "uuid"                => "cnt_av2xquoa",
          "client_id"           => 90289610,
          "email"               => "nolanmurray@klocko.com",
          "phone"               => "1-829-820-5827 x00329",
          "mobile"              => "613-024-9844",
          "title"               => "Chief Strategist",
          "linkedin_url"        => "http://linkedin.com/donnell.hyatt",
          "first_name"          => "Carroll",
          "last_name"           => "Altenwerth",
          "note"                => nil,
          "executive_sponsor"   => false,
          "advocate"            => false,
          "champion"            => false,
          "starred"             => false,
          "street"              => "221 Veum Underpass",
          "city"                => "East Klaramouth",
          "zip"                 => "53544-1850",
          "country"             => "Solomon Islands",
          "timezone"            => nil,
          "salesforce_id"       => nil,
          "client"              => "Joshuah Wintheiser DVM",
          "last_engagement"     => nil,
          "engagement_count"    => 0,
          "custom_field_values" => [],
          "photo_url"           => nil,
          "preferred_name"      => nil,
          "name"                => "Carroll Altenwerth",
          "contact_state"       => "Arizona")
      end

      xcontext "with an emojis in the contact data" do
        let(:client_id) { 90289610 }
        let(:attributes) do
          {
            client_id:                            client_id,
            first_name:                           "💥Tony",
            last_name:                            "💥Smith",
            email:                                "💥test@test.com💥"
          }
        end
        let(:response) { Faraday::Response.new }

        it "strips the emoji from the client name" do
          expect(connection).to receive(:post).with("/v1/clients/90289610/contacts", "{\"email\":\"test@test.com\",\"firstName\":\"Tony\",\"lastName\":\"Smith\"}").and_return(response)
          allow(response).to receive(:body).and_return("customFieldValues" => [])

          service.create(client_id: client_id, attributes: attributes, connection: connection)
        end
      end
    end

    describe "#update" do
      let(:contact_id) { "456" }
      let(:client_id) { "123" }
      let(:attributes) { { first_name: "Tony" } }
      let(:response) { Faraday::Response.new }

      it "does a deep transform on the attributes" do
        expect(connection).to receive(:put).with("/v1/clients/#{client_id}/contacts/#{contact_id}/details", "{\"firstName\":\"Tony\"}").and_return(response)
        allow(response).to receive(:body).and_return("customFieldValues" => [])
        service.update(id: contact_id, client_id: client_id, attributes: attributes, connection: connection)
      end

      # for some reason this is breaking on client succcess. Not sure why yet...
      xcontext "with an emoji in the client name" do
        let(:attributes) { { first_name: "💥Tony", custom_field_values: [{ active_client_success_cycle_id: 1 }] } }

        it "strips the emoji from the attributes" do
          expect(connection).to receive(:put).with("/v1/clients/#{client_id}/contacts/#{contact_id}/details", "{\"firstName\":\"Tony\"}").and_return(response)
          allow(response).to receive(:body).and_return("customFieldValues" => [])
          service.update(id: contact_id, client_id: client_id, attributes: attributes, connection: connection)
        end
      end
    end

    describe "#get_details_by_client_external_id_and_email" do
      let(:client_external_id) { "5372a2ad-7e14-4ea4-a20a-c7a717f9a845" }
      let(:email) { "test@test.com" }

      around(:each) do |example|
        VCR.use_cassette("client_success/contact/get_details_by_client_external_id_and_email") do
          example.run
        end
      end

      context "when the contact is found" do
        it "gets the details" do
          contact = service.get_details_by_client_external_id_and_email(
            client_external_id: client_external_id,
            email: email,
            connection: connection)

          expect(contact).to eq(
            "id" => 12182818,
            "uuid" => "cnt_pzda6yfp",
            "client_id" => 90764325,
            "status_id" => 1,
            "email" => "test@test.com",
            "phone" => nil,
            "mobile" => nil,
            "title" => nil,
            "linkedin_url" => nil,
            "first_name" => "Jimmy",
            "last_name" => "Neutron",
            "note" => nil,
            "executive_sponsor" => true,
            "advocate" => false,
            "champion" => false,
            "starred" => false,
            "key_contact" => false,
            "street" => nil,
            "city" => nil,
            "zip" => nil,
            "country" => nil,
            "timezone" => nil,
            "salesforce_id" => nil,
            "external_id" => nil,
            "client" => "TEST_CLIENT",
            "last_engagement" => nil,
            "engagement_count" => 0,
            "usage_id" => nil,
            "custom_field_values" => [],
            "name" => "Jimmy Neutron",
            "preferred_name" => nil,
            "photo_url" => nil,
            "contact_state" => nil)
        end
      end

      context "when contact is not found" do
        it "raises a not found error" do
          expect(connection).to receive(:get).and_return(Faraday::Response.new)
          expect do
            service.get_details_by_client_external_id_and_email(
              client_external_id: client_external_id,
              email: email,
              connection: connection)
          end.to raise_error(ClientSuccess::Contact::NotFound)
        end
      end
    end
  end
end
