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
    end
  end
end
