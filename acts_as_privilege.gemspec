# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{acts_as_privilege}
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Cyril Wack"]
  s.cert_chain = ["/Users/cyril/gem-public_cert.pem"]
  s.date = %q{2010-04-12}
  s.description = %q{Simple Rails plugin to restrict system access to authorized users.}
  s.email = %q{cyril.wack@gmail.com}
  s.extra_rdoc_files = ["README.rdoc", "lib/ability.rb", "lib/acts_as_privilege.rb", "lib/entity.rb", "lib/privileges_helper.rb"]
  s.files = ["MIT-LICENSE", "README.rdoc", "Rakefile", "VERSION.yml", "generators/acts_as_privilege/USAGE", "generators/acts_as_privilege/acts_as_privilege_generator.rb", "generators/acts_as_privilege/templates/migration.rb", "init.rb", "lib/ability.rb", "lib/acts_as_privilege.rb", "lib/entity.rb", "lib/privileges_helper.rb", "Manifest", "acts_as_privilege.gemspec"]
  s.homepage = %q{http://github.com/cyril/acts_as_privilege}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Acts_as_privilege", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{acts_as_privilege}
  s.rubygems_version = %q{1.3.6}
  s.signing_key = %q{/Users/cyril/gem-private_key.pem}
  s.summary = %q{Simple Rails plugin to restrict system access to authorized users.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
