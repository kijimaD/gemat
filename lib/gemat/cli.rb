# frozen_string_literal: true

require 'thor'

module Gemat
  class Cli < Thor
    desc 'export Gemfile to CSV', 'test'
    def csv
      dsl = Gemat::Dsl.new
      url = Gemat::GetUrl.new(dsl)
      url.run
      Gemat::CsvFormatter.new(url).to_csv
    end
  end
end
