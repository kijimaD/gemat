# frozen_string_literal: true

module Gemat
  class OutDsl
    DEFAULT_COLUMNS = %w[index name repo_url]

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
      when 'name'
        @lambda = name
      when 'repo_url'
        @lambda = repo_url
      when 'index'
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

# "gemat md --column name repo_url"
