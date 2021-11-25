# frozen_string_literal: true

require 'httpclient'
require 'json'

require_relative 'dsl'
require_relative 'get_url'
require_relative 'csv_formatter'

def main
  dsl = Gemat::Dsl.new
  url = Gemat::GetUrl.new(dsl)
  url.run
  Gemat::CsvFormatter.new(url).to_csv
end

main
