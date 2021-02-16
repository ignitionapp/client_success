require "spec_helper"

module ClientSuccess
  RSpec.describe(Connection) do
    let(:access_token) { "124f4ab2-c951-4dd2-9519-5546eaa20bc6" }
    let(:connection) { Connection.authorised(access_token) }

    describe "#strip_emojis" do
      let(:external_id) { "2474027099" }
      let(:attributes) do
        {
          name:                           "💥Tony",
          status_id:                      ::ClientSuccess::Status::TRIAL,
          external_id:                    external_id
        }
      end

      it "should strip the emoji from the attributes" do
        expect(connection.strip_emojis(attributes)).to eq(external_id: "2474027099", name: "Tony", status_id: 3)
      end
    end
  end
end
