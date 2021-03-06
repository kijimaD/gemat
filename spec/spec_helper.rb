# frozen_string_literal: true

require 'bundler/setup'
require 'gemat'
require 'webmock'
require 'vcr'

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    add_filter 'spec'
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  VCR.configure do |c|
    c.cassette_library_dir = 'spec/vcr'
    c.hook_into :webmock
    c.allow_http_connections_when_no_cassette = false
  end

  # rubocop:disable Security/Eval, Style/EvalWithLocation
  def capture(stream)
    begin
      stream = stream.to_s
      eval "$#{stream} = StringIO.new"
      yield
      result = eval("$#{stream}").string
    ensure
      eval("$#{stream} = #{stream.upcase}")
    end
    result
  end
  # rubocop:enable Security/Eval, Style/EvalWithLocation

  # Dynamically require everything
  # root_dir = File.dirname(File.dirname(__FILE__))
  # require_pattern = File.join(root_dir, '**/*.rb')
  # @failed = []

  # Dir.glob(require_pattern).each do |f|
  #   next if f.end_with?('/lib/main.rb')
  #   next if f.include?('/spec')

  #   begin
  #     require_relative f.gsub("#{root_dir}/", '../')
  #   rescue NameError
  #     # May fail if parent class not required yet
  #     @failed << f
  #   end
  # end

  # # Retry unresolved requires
  # @failed.each do |f|
  #   require_relative f.gsub("#{root_dir}/", '../')
  # end
end
