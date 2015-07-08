Gem::Specification.new do |spec|
  spec.name          = 'lita-status'
  spec.version       = '0.0.2'
  spec.authors       = ['Riley Shott']
  spec.email         = ['riley.shott@visioncritical.com']
  spec.description   = 'Allows you to store statuses with Lita'
  spec.summary       = 'Allows you to store statuses with Lita'
  spec.homepage      = 'https://github.com/visioncritical/lita-status'
  spec.license       = 'MIT' 
  spec.metadata      = { 'lita_plugin_type' => 'handler' }

  spec.files         = `git ls-files`.split($RS)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'lita', '>= 4.3'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'rspec', '>= 3.0.0'
  spec.add_development_dependency 'rubocop', '>= 0.28.0'
end
