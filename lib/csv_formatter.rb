# frozen_string_literal: true

module Gemat
  class CsvFormatter < Formatter
    def run
      if @write_path
        CSV.open(@write_path, 'w') do |csv|
          @rows.each { |row| csv << row }
        end
      else
        print "\n\n"
        @rows.each { |row| print row.to_csv }
      end
    end

    private

    def gen_rows
      @rows << @columns.map(&:column_name)
      @gems.each do |gem|
        @rows << @columns.map { |dsl| dsl.call(gem) }
      end
    end
  end
end
