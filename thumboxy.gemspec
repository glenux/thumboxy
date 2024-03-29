# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thumboxy/version'

Gem::Specification.new do |spec|
  spec.name          = "thumboxy"
  spec.version       = Thumboxy::VERSION
  spec.authors       = ["Glenn Y. Rolland"]
  spec.email         = ["glenux@glenux.net"]

  spec.summary       = %q{A minimalist thumbnail server for remote pictures.}
  spec.description   = %q{A minimalist thumbnail server for remote pictures.}
  spec.homepage      = "http://github.com/glenux/minipix"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "sinatra"
  spec.add_runtime_dependency "rmagick"
end
