# frozen_string_literal: true

module Gemat
  class OutDsl
    attr_accessor :column_name

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
