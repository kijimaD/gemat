# frozen_string_literal: true

require 'httpclient'
require 'json'
require 'ruby-progressbar'

require_relative 'in_dsl'
require_relative 'fetcher'
require_relative 'gem'
require_relative 'csv_formatter'
require_relative 'md_formatter'
require_relative 'gemat/version'
require_relative 'gemat/cli'

module Gemat
  class Error < StandardError; end

  class Gemat
    def self.run(&block)
      dsl = InDsl.new
      fetcher = Fetcher.new(dsl)
      fetcher.run
      block.call(fetcher.gems)
    end
  end
end
