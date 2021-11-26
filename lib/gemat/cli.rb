# frozen_string_literal: true

require 'thor'

module Gemat
  class Cli < Thor
    desc 'csv', 'export Gemfile to CSV file'
    def csv
      Gemat.run { |url| CsvFormatter.new(url).to_csv }
    end

    desc 'md', 'export Gemfile to markdown'
    def md
      Gemat.run { |url| MdFormatter.new(url).to_md }
    end
  end
end
