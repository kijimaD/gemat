# frozen_string_literal: true

module Gemat
  class OutDsl
    INDEX = 'index'
    NAME = 'name'
    REPO_URL = 'repo_url'
    GEM_URL = 'gem_url'
    DOC_URL = 'doc_url'
    LATEST_VERSION = 'latest_version'
    AUTHOR = 'author'
    DEFAULT_COLUMNS = [INDEX, NAME, REPO_URL, DOC_URL].freeze

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

    def set_lambda
      case @column_name
      when NAME
        @lambda = name
      when REPO_URL
        @lambda = repo_url
      when INDEX
        @lambda = index
      when DOC_URL
        @lambda = doc_url
      when GEM_URL
        @lambda = gem_url
      when LATEST_VERSION
        @lambda = latest_version
      when AUTHOR
        @lambda = author
      end
    end

    def name
      ->(gem) { gem.response['name'] }
    end

    def index
      ->(gem) { gem.index }
    end

    def repo_url
      ->(gem) { gem.repo_url }
    end

    def doc_url
      ->(gem) { gem.response['documentation_uri'] }
    end

    def gem_url
      ->(gem) { gem.response['gem_uri'] }
    end

    def latest_version
      ->(gem) { gem.response['version'] }
    end

    def author
      ->(gem) { gem.response['authors'] }
    end
  end
end
