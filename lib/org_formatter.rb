# frozen_string_literal: true

module Gemat
  class OrgFormatter < Formatter
    # private

    def gen_rows
      @rows << "| #{@columns.map { |column| column.column_name.ljust(column.max_length) }.join(' | ')} |"
      @rows << "| #{Array.new(@columns.length, '----').join(' + ')} |"
      @gems.each do |gem|
        @rows << "| #{@columns.map { |dsl| dsl.call(gem) }.join(' | ')} |"
      end
    end
  end
end
