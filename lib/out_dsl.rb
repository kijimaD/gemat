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

    # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity
    def set_lambda
      case @column_name
      when NAME
        @lambda = rubygems_response(NAME)
      when REPO_URI
        @lambda = repo_uri
      when INDEX
        @lambda = index
      when DOC_URI
        @lambda = rubygems_response(DOC_URI)
      when GEM_URI
        @lambda = rubygems_response(GEM_URI)
      when LATEST_VERSION
        @lambda = rubygems_response(LATEST_VERSION)
      when AUTHORS
        @lambda = rubygems_response(AUTHORS)
      else
        raise StandardError, "Contain invalid column name `#{@column_name}`!"
      end
    end
    # rubocop:enable Metrics/MethodLength, Metrics/CyclomaticComplexity

    def rubygems_response(column)
      ->(gem) { gem.response[column] }
    end

    def index
      ->(gem) { gem.index }
    end

    def repo_uri
      ->(gem) { gem.repo_uri }
    end
  end
end
