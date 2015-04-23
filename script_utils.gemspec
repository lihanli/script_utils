Gem::Specification.new do |gem|
  gem.name     = 'script_utils'
  gem.version  = '0.0.1'
  gem.summary  = 'script helpers'
  gem.author   = 'Lihan Li'
  gem.email    = 'frankieteardrop@gmail.com'
  gem.homepage = 'https://github.com/lihanli/script-utils'

  gem.add_development_dependency('rspec', '3.2.0')

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ["lib"]
end