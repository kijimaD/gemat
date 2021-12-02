# frozen_string_literal: true

module Gemat
  class Formatter
    def initialize(gems, columns, write_path: nil)
      @gems = gems
      @columns = columns
      @write_path = write_path
      @rows = []
      set_column_name_length
      gen_rows
    end

    def run
      if @write_path
        File.open(@write_path, 'w') do |file|
          each_write(@rows) { |string| file << string }
        end
      else
        print "\n\n"
        each_write(@rows) { |string| print string }
        print "\n"
      end
    end

    private

    def each_write(rows, &proc)
      rows.each do |row|
        proc.call(row)
        proc.call("\n")
      end
    end

    # rubocop:disable Metrics/AbcSize
    def set_column_name_length
      rows = []
      rows << @columns.map(&:column_name)
      @gems.each do |gem|
        rows << @columns.map { |dsl| dsl.call(gem) }
      end
      maxes = rows.transpose.map { |row| row.max { |a, b| a.to_s.length <=> b.to_s.length }.to_s.length }
      maxes.zip(@columns) do |max, column|
        column.max_length = max
      end
    end
    # rubocop:enable Metrics/AbcSize
  end
end
