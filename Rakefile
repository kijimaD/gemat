# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

require_relative 'lib/gemfile_exporter'

RSpec::Core::RakeTask.new(:spec)
namespace :export do
  desc 'CSV export'
  task :csv do
    dsl = GemfileExporter::Dsl.new
    url = GemfileExporter::GetUrl.new(dsl)
    url.run
    GemfileExporter::CsvFormatter.new(url).to_csv
  end
end
