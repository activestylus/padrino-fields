require 'sinatra/base'
require 'dm-core'
require 'dm-validations'
require 'dm-do-adapter'
require 'dm-sqlite-adapter'
require 'haml'

class DataMapperDemo < Sinatra::Base
  register Padrino::Helpers
  configure do
    set :environment, :test
    set :root, File.dirname(__FILE__)
  end
  DataMapper.setup(:default, "sqlite3::memory:")
end

class Person
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :string, String
  property :integer, Integer
  property :boolean, Boolean
  property :decimal, Decimal
  property :float, Float
  property :string, String
  property :text, Text
  property :date, Date
  property :datetime, DateTime
  property :email, String
  property :phone, String
  property :tel, String
  property :url, String
  property :search, String
  property :website, String
  validates_presence_of :name
  has n, :nobodies
end

class Nobody
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  belongs_to :person, :required => false
end

DataMapper.auto_migrate!

