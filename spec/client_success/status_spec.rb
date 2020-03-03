require "spec_helper"

module ClientSuccess
  RSpec.describe(Status) do
    subject(:service) { described_class }

    let(:access_token) { "979e3ce5-5f57-486a-af03-d328f50bd356" }
    let(:connection) { Connection.authorised(access_token) }

    describe "#list-all" do
      around(:each) do |example|
        VCR.use_cassette("client_success/status/list_all") do
          example.run
        end
      end

      it "retreives a list of statuses" do
        statuses = service.list_all(connection: connection)

        expect(statuses).to eq([
          { "id" => 1, "code" => "A", "description" => "Active" },
          { "id" => 2, "code" => "I", "description" => "Inactive" },
          { "id" => 3, "code" => "F", "description" => "Trial" },
          { "id" => 4, "code" => "T", "description" => "Terminated" }
        ])
      end
    end
  end
end
