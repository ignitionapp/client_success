lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "client_success/version"

Gem::Specification.new do |spec|
  spec.name          = "client_success"
  spec.version       = ClientSuccess::VERSION
  spec.authors       = ["Practice Ignition"]
  spec.email         = ["dev@practiceignition.com"]

  spec.summary       = "An unofficial Ruby wrapper for Client Success's REST API"
  spec.homepage      = "https://github.com/ignitionapp/"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency("bundler", "~> 2.0")
  spec.add_development_dependency("rake", "~> 10.0")
  spec.add_development_dependency("rspec", "~> 3.0")

  spec.add_development_dependency("vcr")
  spec.add_development_dependency("faker")

  spec.add_development_dependency("rubocop", "0.77.0")
  spec.add_development_dependency("rubocop-rspec")

  spec.add_runtime_dependency("faraday")
  spec.add_runtime_dependency("faraday_middleware")

  # TODO: don't force the use of typhoeus
  spec.add_runtime_dependency("typhoeus")

  spec.add_runtime_dependency("dry-types", "0.11.0")
  spec.add_runtime_dependency("hashie")

  # TODO: remove activesupport as a dependency
  spec.add_runtime_dependency("activesupport", "~> 5.2")
end
