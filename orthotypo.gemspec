# frozen_string_literal: true

require_relative "lib/orthotypo/version"

Gem::Specification.new do |spec|
  spec.name = "orthotypo"
  spec.version = Orthotypo::VERSION
  spec.authors = ["Arnaud Levy"]
  spec.email = ["arnaud.levy@noesya.coop"]

  spec.summary = "Pour un texte correctement typographié"
  spec.description = "Il y a un corpus riche de règles typographiques, dépendant des langues. Cette gem vise à intégrer ces règles et à automatiser leur mise en application pour le web, quand cela est possible."
  spec.homepage = "https://github.com/noesya/orthotypo"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/noesya/orthotypo"

  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-nc"
  spec.add_development_dependency "byebug"
end
