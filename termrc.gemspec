Gem::Specification.new do |gem|
  gem.authors       = ["Brian Gonzalez"]
  gem.email         = ["me@briangonzalez.org"]
  gem.description   = "Take your iTerm2 environments with you wherever you go."
  gem.summary       = "Take your iTerm2 environments with you wherever you go."
  gem.homepage      = "https://github.com/briangonzalez/termrc"

  gem.files         = `git ls-files`.split($\).reject{|f| f =~ /^images/ } # Exclude images
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.executables   << 'termrc'
  gem.name          = "termrc"
  gem.version       = '0.1.1'
  gem.license       = 'MIT'

  gem.add_runtime_dependency 'thor', '~> 0.18.0'
end