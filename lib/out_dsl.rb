# frozen_string_literal: true

module Gemat
  class OutDsl
    # gem
    INDEX = 'index'
    NAME = 'name'
    REPO_URI = 'repo_uri'
    GEM_URI = 'gem_uri'

    # Rubygems
    DOC_URI = 'documentation_uri'
    LATEST_VERSION = 'version'
    AUTHORS = 'authors'

    # GitHub
    DESCRIPTION = 'description'
    CREATED_AT = 'created_at'
    UPDATED_AT = 'updated_at'
    SIZE = 'size'
    STAR = 'stargazers_count'
    WATCH = 'watchers_count'
    FORKS = 'forks'
    LANGUAGE = 'language'
    ARCHIVED = 'archived'
    DISABLED = 'disabled'
    OPEN_ISSUES_COUNT = 'open_issues_count'
    NETWORK_COUNT = 'network_count'
    SUBSCRIBERS = 'subscribers_count'

    DEFAULT_COLUMNS = [INDEX, NAME, REPO_URI, DOC_URI, SIZE, STAR, CREATED_AT, UPDATED_AT].freeze

    RUBYGEMS_RESPONSE_SOURCES = [NAME, DOC_URI, GEM_URI, LATEST_VERSION, AUTHORS].freeze
    GITHUB_RESPONSE_SOURCES = [DESCRIPTION, CREATED_AT, UPDATED_AT, SIZE, STAR, WATCH,
                               FORKS, LANGUAGE, ARCHIVED, DISABLED, OPEN_ISSUES_COUNT,
                               NETWORK_COUNT, SUBSCRIBERS].freeze
    GEM_SOURCES = [INDEX, REPO_URI].freeze
    ALL_SOURCES = [].concat(GEM_SOURCES, RUBYGEMS_RESPONSE_SOURCES, GITHUB_RESPONSE_SOURCES).freeze

    attr_accessor :column_name

    def self.new_by_array(columns)
      columns.map { |column| new(column) }
    end

    def self.create(columns, all: nil)
      if columns
        new_by_array(columns)
      elsif all
        new_by_array(ALL_SOURCES)
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
      when *RUBYGEMS_RESPONSE_SOURCES
        @lambda = rubygems_response(@column_name)
      when *GITHUB_RESPONSE_SOURCES
        @lambda = github_response(@column_name)
      when *GEM_SOURCES
        @lambda = gem_method(@column_name)
      else
        msg = <<-ERROR.gsub(/^\s+/, '')
          Contain invalid column name `#{@column_name}`!
          valid columns hint: [#{ALL_SOURCES}]
        ERROR
        raise StandardError, msg
      end
    end
    # rubocop:enable Metrics/MethodLength

    def rubygems_response(column)
      ->(gem) { gem.rubygems[column] }
    end

    def github_response(column)
      ->(gem) { gem.github[column] }
    end

    def gem_method(column)
      ->(gem) { gem.send(column) }
    end
  end
end
