# frozen_string_literal: true

module Gemat
  class OutDsl
    INDEX = 'index'
    NAME = 'name'
    REPO_URI = 'repo_uri'
    GEM_URI = 'gem_uri'
    DOC_URI = 'documentation_uri'
    LATEST_VERSION = 'version'
    AUTHORS = 'authors'
    DEFAULT_COLUMNS = [INDEX, NAME, REPO_URI, DOC_URI].freeze

    RESPONSE_SOURCES = [NAME, DOC_URI, GEM_URI, LATEST_VERSION, AUTHORS].freeze
    GEM_SOURCES = [INDEX, REPO_URI].freeze

    attr_accessor :column_name

    def self.new_by_array(columns)
      columns.map { |column| new(column) }
    end

    def self.create(columns)
      if columns
        new_by_array(columns)
      else
        new_by_array(DEFAULT_COLUMNS)
      end
    end

    def initialize(column_name)
      @column_name = column_name

      set_lambda
    end

    def call(gem)
      @lambda.call(gem)
    end

    # rubocop:disable Metrics/MethodLength
    def set_lambda
      case @column_name
      when *RESPONSE_SOURCES
        @lambda = rubygems_response(@column_name)
      when *GEM_SOURCES
        @lambda = gem_method(@column_name)
      else
        msg = <<-ERROR.gsub(/^\s+/, '')
          Contain invalid column name `#{@column_name}`!
          valid columns hint: [#{GEM_SOURCES.join(', ')}, #{RESPONSE_SOURCES.join(', ')}]
        ERROR
        raise StandardError, msg
      end
    end
    # rubocop:enable Metrics/MethodLength

    def rubygems_response(column)
      ->(gem) { gem.response[column] }
    end

    def gem_method(column)
      ->(gem) { gem.send(column) }
    end
  end
end
