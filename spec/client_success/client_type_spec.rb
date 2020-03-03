require "spec_helper"

module ClientSuccess
  RSpec.describe(ClientType) do
    subject(:service) { described_class }

    let(:access_token) { "979e3ce5-5f57-486a-af03-d328f50bd356" }
    let(:connection) { Connection.authorised(access_token) }

    describe "#list_all" do
      around(:each) do |example|
        VCR.use_cassette("client_success/client_type/list_all") do
          example.run
        end
      end

      it "retreives a list of client types" do
        client_types = service.list_all(
          connection: connection)

        expect(client_types).to eq([
          {
            "default_success_cycle_map_id" => nil,
            "description" => nil,
            "id" => 4974,
            "success_cycles" => [],
            "tid" => 328,
            "title" => "Active - High CMI"
          },
          {
            "default_success_cycle_map_id" => nil,
            "description" => nil,
            "id" => 4972,
            "success_cycles" => [],
            "tid" => 328,
            "title" => "Active - Key Account"
          },
          {
            "default_success_cycle_map_id" => nil,
            "description" => nil,
            "id" => 4973,
            "success_cycles" => [],
            "tid" => 328,
            "title" => "Active - Low CMI"
          },
          {
            "default_success_cycle_map_id" => nil,
            "description" => nil,
            "id" => 4783,
            "success_cycles" => [],
            "tid" => 328,
            "title" => "Churned"
          },
          {
            "default_success_cycle_map_id" => nil,
            "description" => nil,
            "id" => 4784,
            "success_cycles" => [],
            "tid" => 328,
            "title" => "Dormant"
          },
          {
            "default_success_cycle_map_id" => nil,
            "description" => nil,
            "id" => 5161,
            "success_cycles" => [],
            "tid" => 328,
            "title" => "Expired Trial"
          },
          {
            "default_success_cycle_map_id" => nil,
            "description" => nil,
            "id" => 4782,
            "success_cycles" => [],
            "tid" => 328,
            "title" => "Onboarding" },
          {
            "default_success_cycle_map_id" => nil,
            "description" => nil,
            "id" => 4781,
            "success_cycles" => [],
            "tid" => 328,
            "title" => "Trial"
          }
        ]
                                  )
      end
    end
  end
end
