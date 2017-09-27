# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "s3diff/version"

Gem::Specification.new do |spec|
  spec.name          = "s3diff"
  spec.version       = S3diff::VERSION
  spec.authors       = ["masa21kik"]
  spec.email         = ["masa21kik@gmail.com"]

  spec.summary       = %q{Show difference between S3 file and local file.}
  spec.description   = %q{Show difference between S3 file and local file.}
  spec.homepage      = "https://github.com/masa21kik/s3diff"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "aws-sdk", "~> 2.10"
  spec.add_dependency "diffy", "~> 3.2"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "test-unit", "~> 3.2"
  spec.add_development_dependency "pry", "~> 0.10"
end
