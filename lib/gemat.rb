# frozen_string_literal: true

require 'bundler'
require 'csv'
require 'httpclient'
require 'json'
require 'ruby-progressbar'
require 'thor'

require_relative 'in_dsl'
require_relative 'out_dsl'
require_relative 'fetcher'
require_relative 'gem'
require_relative 'formatter'
require_relative 'csv_formatter'
require_relative 'md_formatter'
require_relative 'gemat/version'
require_relative 'gemat/cli'

module Gemat
  class Error < StandardError; end

  class Gemat
    def self.run(options = {}, &block)
      dsl = InDsl.new(options[:input])
      outdsls = OutDsl.create(options[:columns])
      fetcher = Fetcher.new(dsl)
      fetcher.run
      block.call(fetcher.gems, outdsls)
    end
  end
end
