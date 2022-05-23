# -*- encoding: utf-8 -*-
# stub: fastlane-plugin-lizard 1.3.3 ruby lib

Gem::Specification.new do |s|
  s.name = "fastlane-plugin-lizard".freeze
  s.version = "1.3.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Moses Liao".freeze]
  s.date = "2020-11-12"
  s.email = "moses.liao.sd@gmail.com".freeze
  s.homepage = "https://github.com/liaogz82/fastlane-plugin-lizard".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.14".freeze
  s.summary = "Run swift code complexity analytics using Lizard".freeze

  s.installed_by_version = "3.3.14" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<fastlane>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<pry>.freeze, [">= 0"])
  else
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<fastlane>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
  end
end
