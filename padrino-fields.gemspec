# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{padrino-fields}
  s.version = "0.3.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Steven Garcia"]
  s.date = %q{2011-03-17}
  s.description = %q{Smart fields for your forms, similar to Formtastic or SimpleForm}
  s.email = %q{stevendgarcia@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.markdown"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.markdown",
    "Rakefile",
    "VERSION",
    "lib/padrino-fields.rb",
    "lib/padrino-fields/form_builder.rb",
    "lib/padrino-fields/form_helpers.rb",
    "lib/padrino-fields/orms/datamapper.rb",
    "lib/padrino-fields/settings.rb",
    "load_paths.rb",
    "padrino-fields.gemspec",
    "test/.DS_Store",
    "test/fixtures/datamapper/app.rb",
    "test/fixtures/datamapper/views/capture_concat.erb",
    "test/fixtures/datamapper/views/capture_concat.haml",
    "test/fixtures/datamapper/views/content_for.erb",
    "test/fixtures/datamapper/views/content_for.haml",
    "test/fixtures/datamapper/views/content_tag.erb",
    "test/fixtures/datamapper/views/content_tag.haml",
    "test/fixtures/datamapper/views/fields_for.erb",
    "test/fixtures/datamapper/views/fields_for.haml",
    "test/fixtures/datamapper/views/form_for.erb",
    "test/fixtures/datamapper/views/form_for.haml",
    "test/fixtures/datamapper/views/form_tag.erb",
    "test/fixtures/datamapper/views/form_tag.haml",
    "test/fixtures/datamapper/views/link_to.erb",
    "test/fixtures/datamapper/views/link_to.haml",
    "test/fixtures/datamapper/views/mail_to.erb",
    "test/fixtures/datamapper/views/mail_to.haml",
    "test/fixtures/datamapper/views/meta_tag.erb",
    "test/fixtures/datamapper/views/meta_tag.haml",
    "test/helper.rb",
    "test/test_datamapper.rb",
    "test/test_form_builder.rb",
    "test/test_form_helpers.rb",
    "test/test_settings.rb"
  ]
  s.homepage = %q{http://github.com/activestylus/padrino-fields}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Advanced form helpers for Padrino framework}
  s.test_files = [
    "test/fixtures/datamapper/app.rb",
    "test/helper.rb",
    "test/test_datamapper.rb",
    "test/test_form_builder.rb",
    "test/test_form_helpers.rb",
    "test/test_settings.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<padrino>, [">= 0"])
      s.add_runtime_dependency(%q<padrino-core>, [">= 0"])
      s.add_runtime_dependency(%q<padrino-helpers>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0.8.7"])
      s.add_development_dependency(%q<mocha>, [">= 0.9.8"])
      s.add_development_dependency(%q<rack-test>, [">= 0.5.0"])
      s.add_development_dependency(%q<fakeweb>, [">= 1.2.8"])
      s.add_development_dependency(%q<webrat>, [">= 0.5.1"])
      s.add_development_dependency(%q<haml>, [">= 2.2.22"])
      s.add_development_dependency(%q<phocus>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 2.10.3"])
      s.add_development_dependency(%q<uuid>, [">= 2.3.1"])
      s.add_development_dependency(%q<bcrypt-ruby>, [">= 0"])
      s.add_development_dependency(%q<ruby-prof>, [">= 0.9.1"])
      s.add_development_dependency(%q<system_timer>, [">= 1.0"])
      s.add_development_dependency(%q<memcached>, [">= 0.20.1"])
      s.add_development_dependency(%q<dalli>, [">= 1.0.2"])
    else
      s.add_dependency(%q<padrino>, [">= 0"])
      s.add_dependency(%q<padrino-core>, [">= 0"])
      s.add_dependency(%q<padrino-helpers>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0.8.7"])
      s.add_dependency(%q<mocha>, [">= 0.9.8"])
      s.add_dependency(%q<rack-test>, [">= 0.5.0"])
      s.add_dependency(%q<fakeweb>, [">= 1.2.8"])
      s.add_dependency(%q<webrat>, [">= 0.5.1"])
      s.add_dependency(%q<haml>, [">= 2.2.22"])
      s.add_dependency(%q<phocus>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 2.10.3"])
      s.add_dependency(%q<uuid>, [">= 2.3.1"])
      s.add_dependency(%q<bcrypt-ruby>, [">= 0"])
      s.add_dependency(%q<ruby-prof>, [">= 0.9.1"])
      s.add_dependency(%q<system_timer>, [">= 1.0"])
      s.add_dependency(%q<memcached>, [">= 0.20.1"])
      s.add_dependency(%q<dalli>, [">= 1.0.2"])
    end
  else
    s.add_dependency(%q<padrino>, [">= 0"])
    s.add_dependency(%q<padrino-core>, [">= 0"])
    s.add_dependency(%q<padrino-helpers>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0.8.7"])
    s.add_dependency(%q<mocha>, [">= 0.9.8"])
    s.add_dependency(%q<rack-test>, [">= 0.5.0"])
    s.add_dependency(%q<fakeweb>, [">= 1.2.8"])
    s.add_dependency(%q<webrat>, [">= 0.5.1"])
    s.add_dependency(%q<haml>, [">= 2.2.22"])
    s.add_dependency(%q<phocus>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 2.10.3"])
    s.add_dependency(%q<uuid>, [">= 2.3.1"])
    s.add_dependency(%q<bcrypt-ruby>, [">= 0"])
    s.add_dependency(%q<ruby-prof>, [">= 0.9.1"])
    s.add_dependency(%q<system_timer>, [">= 1.0"])
    s.add_dependency(%q<memcached>, [">= 0.20.1"])
    s.add_dependency(%q<dalli>, [">= 1.0.2"])
  end
end

