# frozen_string_literal: true

require 'thor'

module Gemat
  class Cli < Thor
    desc 'csv', 'export Gemfile to CSV file'
    def csv
      run { |url| Gemat::CsvFormatter.new(url).to_csv }
    end

    desc 'md', 'export Gemfile to markdown'
    def md
      run { |url| Gemat::MdFormatter.new(url).to_md }
    end

    def run(&block)
      dsl = Gemat::Dsl.new
      url = Gemat::GetUrl.new(dsl)
      url.run
      block.call(url)
    end
  end
end
