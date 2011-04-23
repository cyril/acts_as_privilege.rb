Gem::Specification.new do |s|
  s.name        = "acts_as_privilege"
  s.version     = Psych.load_file("VERSION.yml").values.join('.')
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Cyril Wack"]
  s.email       = ["cyril@gosu.fr"]
  s.homepage    = "http://github.com/cyril/acts_as_privilege"
  s.summary     = %q{Simple privilege solution for Rails.}
  s.description = %q{Simple Rails plugin to restrict system access to authorized users.}

  s.rubyforge_project = "acts_as_privilege"

  s.add_runtime_dependency "railties", ">= 3.0.0"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
end
