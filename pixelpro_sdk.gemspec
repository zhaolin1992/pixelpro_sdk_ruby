# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pixelpro_sdk/version'

Gem::Specification.new do |spec|
  spec.name          = "pixelpro_sdk"
  spec.version       = PixelproSdk::VERSION
  spec.authors       = ["zhaolin"]
  spec.email         = ["zhaodamon@gmail.com"]

  spec.summary       = %q{"Pixel Pro Service SDK"}
  spec.description   = %q{"This gem will help you to build your Pixel Service in Ruby"}
  spec.homepage      = "https://github.com/zhaolin1992/pixelpro_sdk_ruby"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://github.com/zhaolin1992/pixelpro_sdk_ruby"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.files        << Dir['lib/**/*.rb']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.executables   << 'pixelpro_init'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "railties", ">= 3.1.0"
  spec.add_runtime_dependency "thor", "~> 0.19.1"

end
