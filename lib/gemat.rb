# frozen_string_literal: true

require 'httpclient'
require 'json'
require 'ruby-progressbar'

require_relative 'csv_formatter'
require_relative 'md_formatter'
require_relative 'dsl'
require_relative 'gemat/version'
require_relative 'gemat/cli'
require_relative 'get_url'

module Gemat
  class Error < StandardError; end
end
