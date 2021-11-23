# frozen_string_literal: true

require 'httpclient'
require 'json'

require_relative 'dsl'
require_relative 'get_url'

def main
    dsl = GemfileExporter::Dsl.new
    GemfileExporter::GetUrl.new(dsl).run
end

main
