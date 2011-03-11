source :rubygems

group :other do
  gem "builder", ">= 2.1.2"
end

group :db do
  gem "dm-core", ">= 1.0"
  gem "dm-migrations", ">= 1.0"
  gem "dm-validations", ">= 1.0"
  gem "dm-aggregates", ">= 1.0"
  gem "dm-sqlite-adapter", ">= 1.0"
end

group :development do
  gem "rcov"
  gem "jeweler"
  gem "rake",  ">= 0.8.7"
  gem "mocha", ">= 0.9.8"
  gem "rack-test", ">= 0.5.0"
  gem "fakeweb",  ">=1.2.8"
  gem "webrat", ">= 0.5.1"
  gem "haml", ">= 2.2.22"
  gem "phocus"
  gem "shoulda", ">= 2.10.3"
  gem "uuid", ">= 2.3.1"
  gem "bcrypt-ruby", :require => "bcrypt"
  platforms :mri_18 do
    gem "ruby-prof", ">= 0.9.1"
    gem "system_timer", ">= 1.0"
  end
  platforms :mri do
    gem "memcached", ">= 0.20.1"
    gem 'dalli',     ">=1.0.2"
  end
end

gem "padrino"
gem "padrino-core"
gem "padrino-helpers"
