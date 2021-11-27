# frozen_string_literal: true

require 'thor'

module Gemat
  class Cli < Thor
    desc 'csv', 'export Gemfile to CSV file'
    method_options output: :string
    def csv
      Gemat.run(options) { |gems| CsvFormatter.new(gems, options[:output]).to_csv }
    end

    desc 'md', 'export Gemfile to markdown'
    method_options output: :string
    def md
      Gemat.run(options) { |gems| MdFormatter.new(gems, options[:output]).to_md }
    end
  end
end
