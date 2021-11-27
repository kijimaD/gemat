# frozen_string_literal: true

require 'thor'

module Gemat
  class Cli < Thor
    desc 'csv', 'export Gemfile to CSV file'
    def csv
      Gemat.run { |gems| CsvFormatter.new(gems).to_csv }
    end

    desc 'md', 'export Gemfile to markdown'
    def md
      Gemat.run { |gems| MdFormatter.new(gems).to_md }
    end
  end
end
