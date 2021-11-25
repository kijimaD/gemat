# frozen_string_literal: true

require 'thor'

module GemfileExporter
  class Cli < Thor
    desc 'export Gemfile to CSV', 'test'
    def csv
      dsl = GemfileExporter::Dsl.new
      url = GemfileExporter::GetUrl.new(dsl)
      url.run
      GemfileExporter::CsvFormatter.new(url).to_csv
    end
  end
end
