# frozen_string_literal: true

module Gemat
  class OrgFormatter < Formatter
    # private

    # rubocop:disable Metrics/AbcSize
    def gen_rows
      @rows << "| #{@columns.map { |column| column.column_name.ljust(column.max_length) }.join(' | ')} |"
      @rows << "|#{@columns.map { |column| '-' * (column.max_length + 2) }.join('+')}|"
      @gems.each do |gem|
        @rows << "| #{@columns.map { |column| column.call(gem).to_s.ljust(column.max_length) }.join(' | ')} |"
      end
    end
    # rubocop:enable Metrics/AbcSize
  end
end
