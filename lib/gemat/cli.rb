# frozen_string_literal: true

require 'thor'

module Gemat
  class Cli < Thor
    desc 'csv', 'export Gemfile to CSV file'
    def csv
      dsl = Gemat::Dsl.new
      url = Gemat::GetUrl.new(dsl)
      url.run
      Gemat::CsvFormatter.new(url).to_csv
    end

    desc 'md', 'export Gemfile to markdown'
    def md
      dsl = Gemat::Dsl.new
      url = Gemat::GetUrl.new(dsl)
      url.run
      Gemat::MdFormatter.new(url).to_md
    end
  end
end
