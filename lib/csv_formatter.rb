# frozen_string_literal: true

module Gemat
  class CsvFormatter
    def initialize(gems, columns = [OutDsl.new('name'), OutDsl.new('Repo URL')], output: nil)
      @gems = gems
      @columns = columns
      @output = output
      @rows = []
      gen_rows
    end

    def to_csv
      if @output
        CSV.open(@output, 'w') do |csv|
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
