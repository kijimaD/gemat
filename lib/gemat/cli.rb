# frozen_string_literal: true

module Gemat
  class Cli < Thor
    desc 'csv', 'export Gemfile to CSV file'
    method_options input: :string, output: :string, columns: :array
    def csv
      Gemat.run(options) { |gems, columns| CsvFormatter.new(gems, columns, output: options[:output]).to_csv }
    end

    desc 'md', 'export Gemfile to markdown'
    method_options input: :string, output: :string
    def md
      Gemat.run(options) { |gems| MdFormatter.new(gems, options[:output]).to_md }
    end
  end
end
