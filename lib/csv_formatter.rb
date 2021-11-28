# frozen_string_literal: true

module Gemat
  class CsvFormatter < Formatter
    private

    def gen_rows
      @rows << @columns.map(&:column_name).join(',')
      @gems.each do |gem|
        @rows << @columns.map { |dsl| dsl.call(gem) }.join(',')
      end
    end
  end
end
