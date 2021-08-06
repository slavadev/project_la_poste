# frozen_string_literal: true

require_relative "lib/la_poste/version"

Gem::Specification.new do |spec|
  spec.name          = "la_poste"
  spec.version       = LaPoste::VERSION
  spec.authors       = ["Slava Korolev"]
  spec.email         = ["korolvs@gmail.com"]
  spec.summary       = "LaPoste is a service that calculates discounts for delivery transactions"
  spec.required_ruby_version = ">= 2.5.0"

  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
