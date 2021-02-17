require "spec_helper"

module ClientSuccess
  RSpec.describe(Client) do
    subject(:service) { described_class }

    let(:access_token) { "979e3ce5-5f57-486a-af03-d328f50bd356" }
    let(:connection) { Connection.authorised(access_token) }

    describe "#list_all" do
      around(:each) do |example|
        VCR.use_cassette("client_success/client/list_all") do
          example.run
        end
      end

      it "retreives a list of clients" do
        clients = service.list_all(
          connection: connection)

        expect(clients).to eq([
          {
            "id"                             => 90289610,
            "name"                           => "Joshuah Wintheiser DVM",
            "success_score"                  => 60,
            "managed_by_employee_id"         => nil,
            "client_segment_id"              => nil,
            "segment"                        => nil,
            "last_touch_date_time"           => nil,
            "last_touch_type_id"             => nil,
            "last_touch_type"                => nil,
            "active_client_success_cycle_id" => 478852,
            "external_id"                    => "2474027099"
          }
        ])
      end
    end

    describe "#get_details" do
      around(:each) do |example|
        VCR.use_cassette("client_success/client/get_details") do
          example.run
        end
      end

      it "retreives client details" do
        client_details = service.get_details(
          client_id: 90289610,
          connection: connection)

        expect(client_details).to eq(
          "id"                             => 90289610,
          "name"                           => "Joshuah Wintheiser DVM",
          "site_url"                       => "http://rueckerfahey.org/owen",
          "client_segment_id"              => nil,
          "client_segment"                 => nil,
          "zip"                            => "26722-6994",
          "modified_by_employee_id"        => 5082,
          "status_id"                      => 1,
          "inception_date"                 => nil,
          "created_by_employee_id"         => 5082,
          "linkedin_url"                   => "http://linkedin.com/monty",
          "managed_by_employee_id"         => nil,
          "active"                         => true,
          "success_score"                  => 60,
          "active_client_success_cycle_id" => 478852,
          "crm_customer_id"                => nil,
          "note"                           => nil,
          "crm_customer_url"               => nil,
          "zendesk_id"                     => "8680534890",
          "desk_id"                        => "6647924048",
          "terminated_date"                => nil,
          "freshdesk_id"                   => "8017149263",
          "uservoice_id"                   => nil,
          "assigned_sales_rep"             => nil,
          "custom_field_values"            => [],
          "success_cycle_id"               => 2361,
          "salesforce_account_id"          => nil,
          "jira_id"                        => "1191723404",
          "usage_id"                       => "1095676470",
          "key_contact_id"                 => nil,
          "street"                         => "8473 Ethyl Crossing",
          "state"                          => "North Carolina",
          "country"                        => "Mauritius",
          "city"                           => "Crooksport",
          "timezone"                       => nil,
          "nps_score"                      => nil,
          "external_id"                    => "2474027099",
          "assigned_csm"                   => nil)
      end
    end

    describe "#create" do
      around(:each) do |example|
        VCR.use_cassette("client_success/client/create") do
          example.run
        end
      end

      let(:attributes) do
        {
          name:                           Faker::Name.name,
          site_url:                       Faker::Internet.url,
          zip:                            Faker::Address.zip_code,
          linkedin_url:                   Faker::Internet.url(host: "linkedin.com"),
          active:                         true,
          zendesk_id:                     Faker::Number.number(digits: 10),
          desk_id:                        Faker::Number.number(digits: 10),
          freshdesk_id:                   Faker::Number.number(digits: 10),
          jira_id:                        Faker::Number.number(digits: 10),
          usage_id:                       Faker::Number.number(digits: 10),
          street:                         Faker::Address.street_address,
          state:                          Faker::Address.state,
          country:                        Faker::Address.country,
          city:                           Faker::Address.city,
          external_id:                    Faker::Number.number(digits: 10)
        }
      end

      it "creates a new client" do
        client = service.create(
          attributes: attributes,
          connection: connection)

        expect(client).to eq(
          "id"                             => 90289610,
          "name"                           => "Joshuah Wintheiser DVM",
          "site_url"                       => "http://rueckerfahey.org/owen",
          "client_segment_id"              => nil,
          "client_segment"                 => nil,
          "zip"                            => "26722-6994",
          "modified_by_employee_id"        => 5082,
          "status_id"                      => 1,
          "inception_date"                 => nil,
          "created_by_employee_id"         => 5082,
          "linkedin_url"                   => "http://linkedin.com/monty",
          "managed_by_employee_id"         => nil,
          "active"                         => true,
          "success_score"                  => 60,
          "active_client_success_cycle_id" => nil,
          "crm_customer_id"                => nil,
          "note"                           => nil,
          "crm_customer_url"               => nil,
          "zendesk_id"                     => "8680534890",
          "desk_id"                        => "6647924048",
          "terminated_date"                => nil,
          "freshdesk_id"                   => "8017149263",
          "uservoice_id"                   => nil,
          "assigned_sales_rep"             => nil,
          "custom_field_values"            => [],
          "success_cycle_id"               => 2361,
          "salesforce_account_id"          => nil,
          "jira_id"                        => "1191723404",
          "usage_id"                       => "1095676470",
          "key_contact_id"                 => nil,
          "street"                         => "8473 Ethyl Crossing",
          "state"                          => "North Carolina",
          "country"                        => "Mauritius",
          "city"                           => "Crooksport",
          "timezone"                       => nil,
          "nps_score"                      => nil,
          "external_id"                    => "2474027099",
          "assigned_csm"                   => nil)
      end

      xcontext "with an emoji in the client name" do
        let(:external_id) { "2474027099" }
        let(:attributes) do
          {
            name:                           "💥Tony",
            status_id:                      ::ClientSuccess::Status::TRIAL,
            external_id:                    external_id
          }
        end
        let(:response) { Faraday::Response.new }

        it "strips the emoji from the client name" do
          expect(connection).to receive(:post).with("/v1/clients", "{\"name\":\"Tony\",\"statusId\":#{::ClientSuccess::Status::TRIAL},\"externalId\":\"#{external_id}\"}").and_return(response)
          allow(response).to receive(:body).and_return("customFieldValues" => [])

          service.create(attributes: attributes, connection: connection)
        end
      end
    end

    describe "#update" do
      let(:client_id) { "123" }
      let(:attributes) { { first_name: "Tony", custom_field_values: [{ active_client_success_cycle_id: 1 }] } }
      let(:response) { Faraday::Response.new }

      it "does a deep transform on the attributes" do
        expect(connection).to receive(:put).with("/v1/clients/#{client_id}", "{\"firstName\":\"Tony\",\"customFieldValues\":[{\"activeClientSuccessCycleId\":1}]}").and_return(response)
        allow(response).to receive(:body).and_return("customFieldValues" => [])
        service.update(client_id: client_id, attributes: attributes, connection: connection)
      end

      xcontext "with an emoji in the client name" do
        let(:attributes) { { first_name: "💥Tony", custom_field_values: [{ active_client_success_cycle_id: 1 }] } }

        it "strips the emoji from the attributes" do
          expect(connection).to receive(:put).with("/v1/clients/#{client_id}", "{\"firstName\":\"Tony\",\"customFieldValues\":[{\"activeClientSuccessCycleId\":1}]}").and_return(response)
          allow(response).to receive(:body).and_return("customFieldValues" => [])
          service.update(client_id: client_id, attributes: attributes, connection: connection)
        end
      end
    end
  end
end
