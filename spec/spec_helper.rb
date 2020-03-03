require "bundler/setup"
require "client_success"

require "vcr"
require "faker"

VCR.configure do |config|
  config.default_cassette_options = { record: :new_episodes }

  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into(:faraday)
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  # config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with(:rspec) do |c|
    c.syntax = :expect
  end

  config.around(:each) do |example|
    vcr = example.metadata.fetch(:vcr) { false }

    if vcr
      # Options may be `true` (for defaults) or a hash (with custom VCR options)
      options = vcr.is_a?(Hash) ? vcr : {}
      VCR.use_cassette(example.metadata[:full_description].gsub(/0x[a-f0-9]*/, ""), options) do
        example.run
      end
    else
      example.run
    end
  end
end
