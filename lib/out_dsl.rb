# frozen_string_literal: true

module Gemat
  class OutDsl
    INDEX = 'index'
    NAME = 'name'
    REPO_URL = 'repo_url'
    DEFAULT_COLUMNS = [INDEX, NAME, REPO_URL].freeze

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
      end
    end

    def name
      ->(gem) { gem.name }
    end

    def repo_url
      ->(gem) { gem.repo_url }
    end

    def index
      ->(gem) { gem.index }
    end
  end
end
