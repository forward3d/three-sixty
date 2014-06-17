require File.join(File.expand_path('../lib', __FILE__), 'three-sixty', 'version')

Gem::Specification.new do |gem|
  gem.name          = "three-sixty"
  gem.version       = ThreeSixty::VERSION
  gem.authors       = ["Daniel Padden"]
  gem.email         = ["daniel.padden@forward3d.com"]
  gem.description   = %q{Connecting to the 360 api}
  gem.summary       = %q{Gathering data from the 360 api}
  gem.homepage      = ""

  gem.files         = `git ls-files -z`.split("\x0")
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

end
