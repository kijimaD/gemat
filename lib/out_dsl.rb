# frozen_string_literal: true

module Gemat
  class OutDsl
    attr_accessor :column_name

    def initialize(column_name)
      @column_name = column_name

      case column_name
      when 'name'
        @lambda = name
      when 'repo_url'
        @lambda = repo_url
      end
    end

    def call(gem)
      @lambda.call(gem)
    end

    def name
      ->(gem) { gem.name }
    end

    def repo_url
      ->(gem) { gem.repo_url }
    end
  end
end

# "gemat md --column name repo_url"
