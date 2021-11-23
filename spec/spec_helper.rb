require "bundler/setup"
require "gemfile_exporter"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Dynamically require everything
  root_dir = File.dirname(File.dirname(__FILE__))
  require_pattern = File.join(root_dir, '**/*.rb')
  @failed = []

  Dir.glob(require_pattern).each do |f|
    next if f.end_with?('/lib/main.rb')
    next if f.include?('/spec')

    begin
      require_relative f.gsub("#{root_dir}/", '../')
    rescue NameError
      # May fail if parent class not required yet
      @failed << f
    end
  end

  # Retry unresolved requires
  @failed.each do |f|
    require_relative f.gsub("#{root_dir}/", '../')
  end
end
