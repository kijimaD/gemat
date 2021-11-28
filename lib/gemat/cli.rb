# frozen_string_literal: true

module Gemat
  class Cli < Thor
    desc 'csv', 'export Gemfile to CSV file'
    method_options input: :string, write_path: :string, columns: :array
    def csv
      Gemat.run(options) { |gems, columns| CsvFormatter.new(gems, columns, write_path: options[:write_path]).run }
    end

    desc 'md', 'export Gemfile to markdown'
    method_options input: :string, write_path: :string, columns: :array
    def md
      Gemat.run(options) { |gems, columns| MdFormatter.new(gems, columns, write_path: options[:write_path]).run }
    end
  end
end
