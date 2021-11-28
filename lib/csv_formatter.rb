# frozen_string_literal: true

module Gemat
  class CsvFormatter < Formatter
    def run
      if @write_path
        File.open(@write_path, 'w') do |file|
          each_write(@rows) { |string| file << string }
        end
      else
        print "\n\n"
        each_write(@rows) { |string| print string }
      end
    end

    private

    def gen_rows
      @rows << @columns.map(&:column_name).join(',')
      @gems.each do |gem|
        @rows << @columns.map { |dsl| dsl.call(gem) }.join(',')
      end
    end

    def each_write(rows, &proc)
      rows.each do |row|
        proc.call(row)
        proc.call("\n")
      end
    end
  end
end
