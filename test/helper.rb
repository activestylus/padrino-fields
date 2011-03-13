require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rack/test'
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'sinatra'
require 'padrino'
require 'padrino-helpers'
require 'webrat'
require 'mocha'
require 'phocus'
require 'dm-core'
require 'dm-validations'
require 'dm-migrations'
require 'dm-sqlite-adapter'

# We need some extension for do our tests
begin
  # As 2.3.x
  require 'active_support/core_ext/date'
  require 'active_support/core_ext/time'
  require 'active_support/core_ext/numeric'
  require 'active_support/duration'
rescue LoadError
  # As 3.x
  require 'active_support/time'
end

require File.expand_path(File.dirname(__FILE__) + '/fixtures/datamapper/app')
require File.expand_path("../padrino-fields/lib/padrino-fields")

class Test::Unit::TestCase
  include PadrinoFields::Settings
  include Padrino::Helpers::FormHelpers
  include Padrino::Helpers::OutputHelpers
  include Padrino::Helpers::TagHelpers
  include Padrino::Helpers::AssetTagHelpers
  include Rack::Test
  include Rack::Test::Methods
  include Webrat
  include Webrat::Methods
  include Webrat::Matchers

  def app
    DataMapperDemo.tap { |app| app.set :environment, :test }
  end
  
  def field(object=Person.new)
    Padrino::Helpers::FormBuilder::PadrinoFieldsBuilder.new(self, object)
  end
  
  Webrat.configure do |config|
    config.mode = :rack
  end

  def stop_time_for_test
    time = Time.now
    Time.stubs(:now).returns(time)
    return time
  end

  # assert_has_tag(:h1, :content => "yellow") { "<h1>yellow</h1>" }
  # In this case, block is the html to evaluate
  def assert_has_tag(name, attributes = {}, &block)
    html = block && block.call
    matcher = HaveSelector.new(name, attributes)
    raise "Please specify a block!" if html.blank?
    assert matcher.matches?(html), matcher.failure_message
  end

  # assert_has_no_tag, tag(:h1, :content => "yellow") { "<h1>green</h1>" }
  # In this case, block is the html to evaluate
  def assert_has_no_tag(name, attributes = {}, &block)
    html = block && block.call
    attributes.merge!(:count => 0)
    matcher = HaveSelector.new(name, attributes)
    raise "Please specify a block!" if html.blank?
    assert matcher.matches?(html), matcher.failure_message
  end

  # Silences the output by redirecting to stringIO
  # silence_logger { ...commands... } => "...output..."
  def silence_logger(&block)
    orig_stdout = $stdout
    $stdout = log_buffer = StringIO.new
    block.call
    $stdout = orig_stdout
    log_buffer.rewind && log_buffer.read
  end

  # Asserts that a file matches the pattern
  def assert_match_in_file(pattern, file)
    assert File.exist?(file), "File '#{file}' does not exist!"
    assert_match pattern, File.read(file)
  end

  # mock_model("Business", :new_record? => true) => <Business>
  def mock_model(klazz, options={})
    options.reverse_merge!(:class => klazz, :new_record? => false, :id => 20, :errors => {})
    record = stub(options)
    record.stubs(:to_ary => [record])
    record
  end
end

module Webrat
  module Logging
    def logger # :nodoc:
      @logger = nil
    end
  end
end

class Padrino::Helpers::FormBuilder::PadrinoFieldsBuilder
  
  public :setup_label, :hint, :default_radios, :domize
  
end