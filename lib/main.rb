# frozen_string_literal: true

require 'httpclient'
require 'json'

require_relative 'dsl'
require_relative 'get_url'
require_relative 'formatter'

def main
  dsl = GemfileExporter::Dsl.new
  url = GemfileExporter::GetUrl.new(dsl)
  url.run
  GemfileExporter::Formatter.new(url).to_csv
end

main
